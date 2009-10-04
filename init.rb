unless ENV['DISABLE_XSS_SHIELD']
  require 'xss_shield'
else
  class ::String
    def xss_safe
      self
    end
  end

  class ::NilClass
    def xss_safe
      self
    end
  end
end
