package { 'httpd':
  ensure => latest,
}

package { 'firewalld':
  ensure => latest,
}

service { 'httpd':
  ensure     => running,
  enable     => true,
  hasrestart => true,
  hasstatus  => true,
}

service { 'firewalld':
  ensure     => running,
  enable     => true,
  hasrestart => true,
  hasstatus  => true,
} 

service { 'iptables':
  ensure => stopped,
  enable => false, 
  hasrestart => true, 
  hasstatus => true, 
} 
 
file { '/var/www/html/index.html':
  owner   => 'apache',
  group   => 'apache',
  mode    => '0600',
  content => "<h1>This is $hostname.</h1>",
}

exec { 'fw-http':
  path    => '/usr/bin',
  command => 'firewall-cmd --add-service=http',
}

Package['httpd']
  -> File['/var/www/html/index.html']
  -> Service['httpd']

Package['firewalld']
  -> Service['iptables']
  -> Service['firewalld']
  -> Exec['fw-http']

