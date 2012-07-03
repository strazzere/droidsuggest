module DroidSuggest
  class API

    SERVICE_URL = 'https://market.android.com/suggest/SuggRequest'

    class ArgumentError < RuntimeError; end
    class RequestError < RuntimeError; end
    class ResponseError < RuntimeError; end

    def initialize(options={})
      @options = options
      if(@options[:proxy].nil?)
        @options[:proxy] = {}
      end
    end

    def suggest(query=nil)
      if(query.nil? || query.length <= 1)
        raise ArgumentError.new 'The query must be larger than one character long!'
      end

      data = '?query=' + query.to_s

      data += add_param('json', '1')
      data += add_param('type', 'aq')
      data += add_param('blob', @options[:blob])
      data += add_param('blob_sz', @options[:blob_size])
      data += add_param('hl', @options[:language])
      data += add_param('gl', @options[:local])
      data += add_param('ct', @options[:carrier_country])
      data += add_param('c', @options[:backend_id])

      result = parse(send(data))

      return result
    end

    private

    def parse(data=nil)
      if(data.nil?)
        raise ArgumentError.new 'Unable to parse a nil object!'
      end

      parsed = []
      json = JSON.parse data
      position = 0
      json.each do |suggestion|
        item = {
          :position => position,
          :suggestion => suggestion['s'],
          :suggestion_type => resolve_suggestion_type(suggestion['t'])
        }

        # Package name is not required
        if(!suggestion['p'].nil?)
          item[:package_name] = suggestion['p']
        end

        # Backend id is not required
        if(!suggestion['b'].nil?)
          item[:backend_id] = suggestion['b']
        end

        # Icon url is not required
        if(!suggestion['u'].nil?)
          item[:icon_url] = suggestion['u']
        end
        parsed << item
        position += 1
      end

      return parsed
    end

    def send(data=nil)
      if(data.nil?)
        raise ArgumentError.new 'Unable to send an empty request!'
      end

      url = URI.parse(SERVICE_URL + data.to_s)
      http = Net::HTTP.new(url.host,
                           url.port,
                           @options[:proxy][:proxy_address],
                           @options[:proxy][:proxy_port],
                           @options[:proxy][:proxy_login],
                           @options[:proxy][:proxy_password])
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      response = http.get URI::escape(url.request_uri)
      return response.body if response.is_a?(Net::HTTPSuccess)
      raise ResponseError.new 'Something went wrong, expected a Net::HTTPSuccess object but got ' + response.class.to_s
    end

    def add_param(param_name=nil, param_value=nil)
      if(param_name.nil?)
        raise ArgumentError.new 'Cannot add a parameter without a name for it!'
      end

      if(param_value.nil?)
        return ''
      else
        return '&' + param_name.to_s + '=' + param_value.to_s
      end
    end

    def resolve_suggestion_type(suggestion_type=nil)
      case(suggestion_type)
      when 'a'
        return 'APPLICATION'
      when 'q'
        return 'QUERY'
      else
        return 'UNKNOWN'
      end
    end
  end
end
