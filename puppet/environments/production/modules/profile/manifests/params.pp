# == Class profile::params
#
# This class is meant to be called from profile.
# It sets variables according to platform.
#
class profile::params {
  unless 'RedHat' == $::osfamily {
    fail("Operating system ${::operatingsystem} not supported!")
  }
}
