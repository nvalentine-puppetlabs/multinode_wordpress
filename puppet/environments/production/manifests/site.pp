filebucket { 'main':
    server => $::servername,
      path   => false,
}

File { backup => 'main' }

$force_noop_real = str2bool( pick( $::force_noop, hiera('force_noop', 'true') ) )
if $force_noop_real {
    notify { "Puppet noop safety latch is enabled in site.pp!": }
    noop()
}

hiera_include('classes','','')

class { 'firewall': ensure => stopped, }
