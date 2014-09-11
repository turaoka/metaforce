module Metaforce
  module Metadata
    class Client < Metaforce::AbstractClient
      require 'metaforce/metadata/client/file'
      require 'metaforce/metadata/client/crud'

      include Metaforce::Metadata::Client::File
      include Metaforce::Metadata::Client::CRUD

      endpoint :metadata_server_url
      wsdl Metaforce.configuration.metadata_wsdl

      def inspect
        "#<#{self.class} @options=#{@options.inspect}>"
      end
      
      def server_url
        unless @server_url
          url = URI @options[:server_url]
          url.path = ''
          @server_url = url.to_s
        end
        @server_url
      end
    end
  end
end
