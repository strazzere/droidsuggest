module DroidSuggest
  class API

    SERVICE_URL = 'https://market.android.com/suggest/SuggRequest'

    def initialize(language=nil, locale=nil, proxy={})
      @locale = locale
      @language = language
      @proxy = proxy
    end

    def suggest(query=nil)
      if(query.nil? || query.length <= 1)

      end

      data = '?json=1&query=' + query.to_s

      if(!@language.nil?)
        data += '&hl=' + @language.to_s
      end

      if(!@local.nil?)
        data += '&gl=' + @local.to_s
      end

      result = parse(send(data))

      return result
    end

    private

    def parse(data=nil)
      return data
    end

    def send(data=nil)
      if(data.nil?)

      end

      url = URI.parse(SERVICE_URL + data.to_s)
      http = Net::HTTP.new(url.host, url.port, @proxy[:proxy_address], @proxy[:proxy_port], @proxy[:proxy_login], @proxy[:proxy_password])
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      return http.get URI::escape(url.request_uri)

    end
  end
end
