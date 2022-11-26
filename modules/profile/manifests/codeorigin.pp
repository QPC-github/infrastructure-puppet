# @summary code origin server
# @summary $cdn_access_key cdn access key
class profile::codeorigin (
  String                 $cdn_access_key = lookup('profile::codeorigin::cdn_access_key'),
  Array[Stdlib::Fqdn, 1] $hostnames      = lookup('profile::codeorigin::hostnames'),
) {
  git::clone { 'codeorigin':
    path   => '/srv/codeorigin',
    remote => 'https://github.com/jquery/codeorigin.jquery.com',
    branch => 'main',
    owner  => 'root',
    group  => 'www-data',
  }

  nginx::site { 'codeorigin':
    content => template('profile/codeorigin/site.nginx.erb'),
  }

  nftables::allow { 'codeorigin-http':
    proto => 'tcp',
    dport => 80,
  }
  nftables::allow { 'codeorigin-https':
    proto => 'tcp',
    dport => 443,
  }
}
