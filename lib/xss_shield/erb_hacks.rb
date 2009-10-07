# Create our own ERB compiler to handle <%= %> differently.
# See /usr/lib64/ruby/1.8/erb.rb.
class XssShieldERB < ERB
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

    compiler = XssShieldERB::Compiler.new(trim_mode)

    # NOTE: End changed lines
    set_eoutvar(compiler, eoutvar)
    @src = compiler.compile(str)
    @filename = nil
  end
end

# Use our own ERB handler.
# See /usr/lib/ruby/gems/1.8/gems/actionpack-2.3.4/lib/action_view/template_handlers/erb.rb.
module ActionView
  module TemplateHandlers
    class XssShieldERB < TemplateHandler
      include Compilable

      cattr_accessor :erb_trim_mode
      self.erb_trim_mode = '-'

      def compile(template)
        ::XssShieldERB.new("<% __in_erb_template=true %>#{template.source}", nil, erb_trim_mode, '@output_buffer').src
      end
    end
  end
end

ActionView::Template.register_default_template_handler(
  :erb, ActionView::TemplateHandlers::XssShieldERB)

