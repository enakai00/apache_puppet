package { 'httpd':
  ensure => latest, 
} 

service { 'httpd':
  ensure => running,
  enable => true, 
  hasrestart => true, 
  hasstatus => true, 
} 

service { 'iptables':
  ensure => stopped,
  enable => false, 
  hasrestart => true, 
  hasstatus => true, 
} 

file { '/var/www/html/index.html':
  owner => 'apache',
  group => 'apache',
  mode => '0600',
  content => "<h1>This is $hostname</h1>",
}

Package['httpd']
  -> File['/var/www/html/index.html']
  -> Service['httpd']
  -> Service['iptables']
