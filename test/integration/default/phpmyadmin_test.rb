require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS


describe package('apt-transport-https') do
  it { should be_installed }
end

describe package('percona-server-client') do
  it { should be_installed }
end

describe package('percona-server-server-5.5') do
  it { should be_installed }
end

describe package('php5-redis') do
  it { should be_installed }
end


describe package('php5-memcache') do
  it { should be_installed }
end

describe package('php5-memcached') do
  it { should be_installed }
end

describe package('php5-cli') do
  it { should be_installed }
end

describe package('php5-fpm') do
  it { should be_installed }
end



# Server/Daemon tests

# Nginx/Web server

describe "Web Server" do

  context package('nginx') do
    it { should be_installed }
  end

  it "is listening on port 80" do
    expect(port(80)).to be_listening
  end

  it "has a running service of nginx" do
    expect(service("nginx")).to be_running
  end
  
end

