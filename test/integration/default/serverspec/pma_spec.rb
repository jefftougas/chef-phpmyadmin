require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

describe user('phpmyadmin') do
  it { should exist }
end

describe user('phpmyadmin') do
  it { should have_login_shell '/usr/sbin/nologin' }
end

describe file('/etc/apache2/sites-available/phpmyadmin.conf') do
  it { should be_file }
end

describe file('/etc/apache2/sites-enabled/phpmyadmin.conf') do
  it { should be_file }
end

describe command('mysql -uroot -ptherootisonfire --skip-column-names --batch -e \'show databases like "%phpmyadmin%" \'') do
  it { should return_stdout 'phpmyadmin' }
end