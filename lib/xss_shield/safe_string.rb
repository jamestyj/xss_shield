class SafeString < String
  def to_s
    self
  end
  def to_xss_safe
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
  def to_xss_safe
    ERB::Util.h(to_s).xss_safe
  end
end

