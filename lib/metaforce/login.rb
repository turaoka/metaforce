module Metaforce
  class Login
    def initialize(username, password, security_token=nil, host=nil)
      @username, @password, @security_token = username, password, security_token
      @host = host || 'login.salesforce.com'
    end

    # Public: Perform the login request.
    #
    # Returns a hash with the session id and server urls.
    def login
      response = client.request(:login) do
        soap.body = {
          :username => username,
          :password => password
        }
      end
      response.body[:login_response][:result]
    end

  private

    # Internal: Savon client.
    def client
      @client ||= Savon.client(Metaforce.configuration.partner_wsdl) do |wsdl|
        wsdl.endpoint = Metaforce.configuration.endpoint(host)
      end.tap { |client| client.http.auth.ssl.verify_mode = :none }
    end
    
    def host
      @host
    end

    # Internal: Usernamed passed in from options.
    def username
      @username
    end

    # Internal: Password + Security Token combined.
    def password
      [@password, @security_token].join('')
    end
  end
end
