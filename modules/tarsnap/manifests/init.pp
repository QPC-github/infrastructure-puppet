# @summary manages the tarsnap backup client
class tarsnap () {
  file { '/usr/share/keyrings/tarsnap-archive-keyring.asc':
    ensure  => file,
    source  => 'puppet:///modules/tarsnap/tarsnap-archive-keyring.asc',
    # let the tarsnap-archive-keyring package take over once installed
    replace => false,
  }

  apt::source { 'tarsnap':
    location => "http://pkg.tarsnap.com/deb/${debian::codename()}",
    release  => '',
    repos    => './',
    keyring  => '/usr/share/keyrings/tarsnap-archive-keyring.asc',
    pin      => 150,
  }

  ensure_packages([
    'tarsnap',
    'tarsnap-archive-keyring'
  ], {
    require => Class['Apt::Update'],
  })
}
