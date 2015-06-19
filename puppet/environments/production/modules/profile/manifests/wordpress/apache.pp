class profile::wordpress::apache(
  $db_blog_password = 'myblog',
  $db_blog_user = 'myblog',
  $blogname = 'myblog'
) inherits ::profile::params {

  multi_validate_re($db_blog_password, $db_blog_user, $blogname, '^.+$')

  require ::apache, ::apache::mod::php
  require ::mysql::client, ::mysql::bindings::php

  $_db_host = query_nodes("@@Mysql::Db[${blogname}]", 'ipaddress_eth1')
  $db_host = $_db_host[0]
  validate_re($db_host, '^.+')

  notify { "Database host: ${db_host}": } ->

  class { '::wordpress':
    install_dir => '/var/www/html',
    version => '4.2.2',
    create_db => false,
    create_db_user => false,
    db_name => $blogname,
    db_user => $db_blog_user,
    db_password => $db_blog_password,
    db_host => $db_host,
  }
}
