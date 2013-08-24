package { 'httpd':
  ensure => latest, 
} 

service { 'httpd':
  ensure => running,
  enable => true, 
  hasrestart => true, 
  hasstatus => true, 
} 

file { '/var/www/html/index.html':
  owner => 'apache',
  group => 'apache',
  mode => '0600',
  content => "<h1>This is $hostname</h1>",
}

exec { 'fw-http':
  path => '/usr/sbin',
  command => 'lokkit -s http',
}

Package['httpd']
  -> File['/var/www/html/index.html']
  -> Service['httpd']
  -> Exec['fw-http']
