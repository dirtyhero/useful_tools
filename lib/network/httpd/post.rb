module Network
  class Post
    attr_accessor :host, :port, :params
    def initialize( host, port = 80 , params = {})
      @host = host
      @port = port
      @params = params
    end

    def connect (use_ssl: false )
      uri = URI.parse( self.host )
      http = Net::HTTP.new(uri.host, uri.port)
      if use_ssl
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end
      req = Net::HTTP::Post.new( uri.path )
      req.set_form_data(self.params)
      res = Net::HTTP.start( uri.host, uri.port ) { |http_obj|
       http_obj.request(req)
      }
      return res.body
    end
  end
end