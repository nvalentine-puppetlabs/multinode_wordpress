class profile::wordpress::mysql(
  $db_root_password = undef,
  $db_blog_user = 'myblog',
  $db_blog_password = 'myblog',
  $blogname = 'myblog',

) inherits ::profile::params {

  multi_validate_re($blogname, $db_blog_password, $db_blog_user, '^.+$')

  class { '::mysql::server':
    root_password => $db_root_password,
    override_options => {
      'mysqld' => {
        'bind-address' => $::ipaddress_eth1
      }
    },
  }

  @@::mysql::db { $blogname:
    ensure => present,
    user => $db_blog_user,
    password => $db_blog_password,
    host => '%',
    grant => ['ALL'],
  }
}
