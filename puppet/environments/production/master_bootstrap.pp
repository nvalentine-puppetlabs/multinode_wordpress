node /^master\..+/ {

  service { ['pe-puppetserver', 'pe-httpd']:
    ensure => running,
    enable => true,
  }

  file { 'puppet environment dir':
    ensure => link,
    force => true,
    path => '/etc/puppetlabs/puppet/environments',
    target => '/vagrant/puppet/environments',
  } ->

  file { 'hiera.yaml':
    ensure => link,
    force => true,
    path => '/etc/puppetlabs/puppet/hiera.yaml',
    target => '/etc/puppetlabs/puppet/environments/production/hiera.yaml',
    notify => Service['pe-puppetserver', 'pe-httpd'],
  }

  class { '::firewall': ensure => stopped, }
}
