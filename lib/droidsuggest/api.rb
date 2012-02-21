module DroidSuggest
  class API

    SERVICE_URL = 'https://market.android.com/suggest/SuggRequest'

    class ArgumentError < RuntimeError; end
    class RequestError < RuntimeError; end
    class ResponseError < RuntimeError; end

    def initialize(language=nil, locale=nil, proxy=nil)
      @locale = locale
      @language = language

      if(proxy.nil?)
        @proxy = {}
      end
    end

    def suggest(query=nil)
      if(query.nil? || query.length <= 1)
        raise ArgumentError.new 'The query must be larger than one character long!'
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
      if(data.nil?)
        raise ArgumentError.new 'Unable to parse a nil object!'
      end

      parsed = {}
      json = JSON.parse data
      for i in (1..json.length-1)
        parsed[i] = json[i-1]['s']
      end

      return parsed
    end

    def send(data=nil)
      if(data.nil?)
        raise ArgumentError.new 'Unable to send an empty request!'
      end

      url = URI.parse(SERVICE_URL + data.to_s)
      http = Net::HTTP.new(url.host, url.port, @proxy[:proxy_address], @proxy[:proxy_port], @proxy[:proxy_login], @proxy[:proxy_password])
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      response = http.get URI::escape(url.request_uri)
      return response.body if response.is_a?(Net::HTTPSuccess)
      raise ResponseError.new 'Something went wrong, expected a Net::HTTPSuccess object but got ' + response.class.to_s
    end
  end
end
