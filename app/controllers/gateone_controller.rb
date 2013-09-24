require 'cgi'
require 'openssl'
require 'json'

class GateoneController < ApplicationController
  before_filter :find_project, :authorize
  def index
    secret = Setting["plugin_gateone"][:api_secret]
    authobj = {
      'api_key' => Setting["plugin_gateone"][:api_key],
      'upn' => User.current.login,
      'timestamp' => (Time.now.getutc.to_i * 1000).inspect,
      'signature_method' => 'HMAC-SHA1',
      'api_version' => '1.0'
    }
    authobj['signature'] = OpenSSL::HMAC.hexdigest('sha1', secret, authobj['api_key'] + authobj['upn'] + authobj['timestamp'])
    @valid_json_auth_object = authobj

    respond_to do |format|
      format.html
    end
  end

  def find_project
    @project = Project.find(params[:project_id])
  end
end
