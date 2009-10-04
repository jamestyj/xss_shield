class SafeString < String
  def to_s
    self
  end
  def to_s_xss_protected
    self
  end
end

class String
  def xss_safe
    SafeString.new(self)
  end
end

class NilClass
  def xss_safe
    self
  end
end

# ERB::Util.h and (include ERB::Util; h) are different methods
module ERB::Util
  class <<self
    def h_with_xss_protection(*args)
      h_without_xss_protection(*args).xss_safe
    end
    alias_method_chain :h, :xss_protection
  end
  
    def h_with_xss_protection(*args)
      h_without_xss_protection(*args).xss_safe
    end
    alias_method_chain :h, :xss_protection
end

class Object
  def to_s_xss_protected
    ERB::Util.h(to_s).xss_safe
  end
end

class Array
  def join_xss_protected(sep="")
    map(&:to_s_xss_protected).join(sep.to_s_xss_protected).xss_safe
  end
end
