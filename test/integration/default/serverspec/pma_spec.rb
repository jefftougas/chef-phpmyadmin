require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

describe user('phpmyadmin') do
  it { should exist }
end

describe user('phpmyadmin') do
  it { should have_login_shell '/usr/sbin/nologin' }
end