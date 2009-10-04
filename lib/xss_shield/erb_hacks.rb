# Create our own ERB compiler to handle <%= %> differently.
# See /usr/lib/ruby/1.8/erb.erb.
class XSSProtectedERB < ERB
  class Compiler < ::ERB::Compiler
    def compile(s)
      out = Buffer.new(self)

      content = ''
      scanner = make_scanner(s)
      scanner.scan do |token|
        if scanner.stag.nil?
          case token
          when PercentLine
            out.push("#{@put_cmd} #{content.dump}") if content.size > 0
            content = ''
            out.push(token.to_s)
            out.cr
          when :cr
            out.cr
          when '<%', '<%=', '<%#'
            scanner.stag = token
            out.push("#{@put_cmd} #{content.dump}") if content.size > 0
            content = ''
          when "\n"
            content << "\n"
            out.push("#{@put_cmd} #{content.dump}")
            out.cr
            content = ''
          when '<%%'
            content << '<%'
          else
            content << token
          end
        else
          case token
          when '%>'
            case scanner.stag
            when '<%'
              if content[-1] == ?\n
                content.chop!
                out.push(content)
                out.cr
              else
                out.push(content)
              end
            when '<%='
              # NOTE: Changed lines

              # Don't escape yield statements (they should already be safe)
              if content =~ /^[ \t]*yield[ |\(]/
                to_string = 'to_s'
              else
                to_string = 'to_xss_safe'
              end
              out.push("#{@insert_cmd}((#{content}).#{to_string})")

              # NOTE: End changed lines
            when '<%#'
              # out.push("# #{content.dump}")
            end
            scanner.stag = nil
            content = ''
          when '%%>'
            content << '%>'
          else
            content << token
          end
        end
      end
      out.push("#{@put_cmd} #{content.dump}") if content.size > 0
      out.close
      out.script
    end

  end

  def initialize(str, safe_level=nil, trim_mode=nil, eoutvar='_erbout')
    @safe_level = safe_level
    # NOTE: Changed lines

    compiler = XSSProtectedERB::Compiler.new(trim_mode)

    # NOTE: End changed lines
    set_eoutvar(compiler, eoutvar)
    @src = compiler.compile(str)
    @filename = nil
  end
end

# Use our own ERB handler.
# See /usr/lib/ruby/gems/1.8/gems/actionpack-2.1.0/lib/action_view/template_handlers/erb.rb.
module ActionView
  module TemplateHandlers
    class ERB < TemplateHandler
      def compile(template)
        ::XSSProtectedERB.new(template.source, nil, @view.erb_trim_mode).src
      end
    end
  end
end

