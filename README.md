# chef-phpmyadmin


A Chef cookbook for the popular MySQL management application PHPMyAdmin

This started out as a fork of the original here: https://github.com/priestjim/chef-phpmyadmin
but, because we wanted to keep the packages of PHP consistent between all our boxen, we've decided
to maintain it separately, using PHP 5.4 from Dotdeb. 

The goal is to use this cookbook in our production servers, with some customizations for single sign on
for Pressable customers. Hopefully, others can use this to install PHPMyAdmin in their infrastructure as well.


## Chef Requirements


This depends on the following cookbooks

* apache2
* percona
* apt-dotdeb
* zk-php

## Supported Operating Systems


This cookbook supports the following Linux distributions:

* Ubuntu
* Debian

## Installation

By itself, this cookbook is fairly useless. I can't think of a reason why you would want
to install phpmyadmin to a local server without any databases, or other web apps installed

Ideally, this cookbook is included in your larger set of infrastructure cookbooks, using Berkshelf
or something along the lines.

### Getting it to work on OS X

1. Install VirtualBox and Vagrant (https://www.virtualbox.org/wiki/Downloads)
2. Install Vagrant (http://www.vagrantup.com/downloads.html)

Open up your terminal and add some Vagrant plugins

```bash
vagrant plugin install vagrant-berkshelf
vagrant plugin install vagrant-hostsupdater
vagrant plugin install vagrant-omnibus
```


```Berksfile

 ... your other stuff.

 cookbook 'phpmyadmin',
    :git => git@github.com:pressable/chef-phpmyadmin.git

```

1. Add `phpmyadmin::default` to your runlist.


## Testing

This utilizes Test Kitchen (http://kitchen.ci/) for unit tests. 

```bash
 git clone git@github.com:pressable/chef-phpmyadmin.git
 cd chef-phpmyadmin
 kitchen test
```

### Rackspace Cloud Testing 

You'll need to specify a Rackspace Username/API Key in order for the test to run. 

```bash
 export RACKSPACE_CI_USERNAME="your.username.for.mycloud.rackspace.com"
 export RACKSPACE_CI_API_KEY="your.rackspace.password.or.api.key"
 cp kitchen.rackspace.yml .kitchen.local.yml
 kitchen test
 ....
 kitchen destroy
 ```

Don't forget to destroy the test instance, or you'll incur usage fees from Rackspace. 


Attributes
==========

This cookbook supports the following attributes:

* `version`: The desired PMA version
* `checksum`: The sha256 checksum of the PMA desired version
* `mirror`: The desired PMA download mirror
* `fpm`: Enables the PMA FPM instance for serving via NGINX
* `home`: The desired PMA installation home
* `user`: The user PMA runs as
* `group`: The group PMA runs as
* `socket`: The socket that FPM will be exposing for PMA
* `upload_dir`: The directory PMA will be using for uploads
* `save_dir`: The directory PMA will be using for file saves
* `maxrows`: The maximum rows PMA shall display in a table view
* `protect_binary`: Define the binary field protection PMA will be using
* `default_lang`: The default language PMA will be using
* `default_display`: The default display of rows inside PMA
* `query_history`: Enable or disable the Javascript query history
* `query_history_size`: Set the maximum size of the Javascript query history

LWRP Methods
============

## phpmyadmin_db

This cookbook defines a phpmyadmin_db LWRP for dynamic DB definitions. This LWRP allows the following methods:

* `name`: This is the description of the defined database. It also gets converted to lowercase and spaces substituted to underscores for the database filename. This is the **name attribute**
* `host`: The database host. It can be either a hostname or an IP.
* `port`: The database port.
* `username`: The database username.
* `password`: The database password
* `hide_dbs`: An array of databases we do not want to be shown. This will be concatenated in a form of '^db1|db2$' etc.
* `pma_database`: If you have configured your database server for PMA, you can define here the PMA database name
* `pma_username`: If you have configured your database server for PMA, you can define here the PMA username
* `pma_password`: If you have configured your database server for PMA, you can define here the PMA password

## phpmyadmin_pmadb

This cookbook defines a phpmyadmin_pmadb LWRP for dynamically defining the control databases of PHPMyAdmin for earch server. This LWRP allows the following methods:

* `name`: The block name. Define it for uniqueness. This is the **name attribute**
* `host`: The database host. It can be either a hostname or an IP.
* `port`: The database port.
* `root_username`: The root username (root or admin usually) in order to create the database and needed privileges.
* `root_password`: The root password
* `pma_database`: This is the name of the PMA control database.
* `pma_username`: The PMA control database username
* `pma_password`: The PMA control database password
* `auth_type`: The authentication method PMA will use

Usage
=====

The cookbook installs the selected PMA version to /opt/phpmyadmin (or anywhere else you may have defined in the 'home' attribute) and optionally defines an FPM pool for NGINX or Apache2/mod_fcgid

To define a database config you can use the phpmyadmin_db LWRP such as:

	phpmyadmin_db 'Test DB' do
		host '127.0.0.1'
		port 3306
		username 'root'
		password 'password'
		hide_dbs %w{ information_schema mysql phpmyadmin performance_schema }
	end

This will create a file in /opt/phpmyadmin/conf.d/test_db.inc.php and will be automatically included when you display the PMA page.

License
=======

Copyright 2012 Panagiotis Papadomitsos.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
