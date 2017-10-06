module Requests
  module JsonHelpers

    def json
      @json ||= JSON.parse(response.body)
    end

    def set_headers(auth_token=nil)
      request.env['HTTP_AUTH_TOKEN'] = auth_token
    end
  end
end