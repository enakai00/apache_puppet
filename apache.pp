package { 'httpd':
  ensure => latest, 
}

service { 'httpd':
  ensure => stopped,
}
