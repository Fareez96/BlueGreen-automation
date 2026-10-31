class baseline::ssh {
  file { '/etc/ssh/sshd_config.d/99-hardening.conf':
    ensure  => file,
    owner   => 'root',
    mode    => '0644',
    content => "PermitRootLogin no\nPasswordAuthentication no\nMaxAuthTries 3\n",
    notify  => Service['ssh'],
  }

  service { 'ssh':
    ensure => running,
    enable => true,
  }
}
