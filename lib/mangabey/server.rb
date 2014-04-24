require 'nfsadmin'
require 'sinatra'
require 'json'
require 'erb'

module Mangabey

  class Server < Sinatra::Base

    exportsfile = '/etc/exports'

    set :static, true
    set :bind, '0.0.0.0'
    set :port, 3333
    set :public_folder, Proc.new { File.join(root, 'public') }

    get '/' do
      erb :index
    end

    get '/exports' do
      puts 'Getting all shares'
      content_type :json
      JSON.pretty_generate({ :exports => Nfsadmin::Tasks.get_shares(exportsfile)})
    end

    get '/exports/*' do
      puts  "Finding share: /#{params[:splat][0]}"
      content_type :json
      JSON.pretty_generate(Nfsadmin::Tasks.get_share(exportsfile, "/#{params[:splat][0]}"))
    end

    post '/exports/*' do
      begin
        request.body.rewind
        @request_payload = JSON.parse request.body.read
      rescue
        fail 'Must POST a valid JSON document'
      end
      location = '/' + params[:splat][0]
      user = @request_payload['owner']
      group = @request_payload['group']
      mode = @request_payload['mode']
      acl = @request_payload['acl']
      # Bug in nfsadmin for now: only 1 address+option combo allowed..
      address = acl[0]['address']
      options = acl[0]['options']
      puts "Creating new share: #{location} with options: #{address}(#{options})"
      Nfsadmin::Tasks.create_share(exportsfile,location,address,options,true,user,group, mode)
      Nfsadmin::Tasks.reload_config
    end

    delete '/exports/*' do
      content_type :json
      location = '/' + params[:splat][0]
      puts "Deleting share: #{location}"
      begin
        Nfsadmin::Tasks.delete_share(exportsfile,location)
        Nfsadmin::Tasks.reload_config
        '{ "result": "true" }'
      rescue
        '{ "result": "false" }'
      end
    end
  end

end
