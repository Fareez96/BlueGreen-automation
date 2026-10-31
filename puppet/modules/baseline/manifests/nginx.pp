class baseline::nginx {
  $web_root   = $baseline::web_root
  $blue_port  = $baseline::blue_port
  $green_port = $baseline::green_port

  # Custom fact: which color is live right now (defaults to blue)
  $active_color = $facts['active_color'] ? {
    undef   => 'blue',
    default => $facts['active_color'],
  }

  $active_port = $active_color ? {
    'green' => $green_port,
    default => $blue_port,
  }

  file { '/etc/bluegreen':
    ensure => directory,
  }

  # Created once; Ansible changes it during a switch (Puppet won't overwrite it)
  file { '/etc/bluegreen/active_color':
    ensure  => file,
    content => "blue\n",
    replace => false,
    require => File['/etc/bluegreen'],
  }

  file { [$web_root, "${web_root}/blue", "${web_root}/green"]:
    ensure => directory,
  }

  # Placeholder pages; Ansible deploys the real app versions later
  file { "${web_root}/blue/index.html":
    ensure  => file,
    content => "<h1>BLUE placeholder</h1>\n",
    replace => false,
    require => File["${web_root}/blue"],
  }

  file { "${web_root}/green/index.html":
    ensure  => file,
    content => "<h1>GREEN placeholder</h1>\n",
    replace => false,
    require => File["${web_root}/green"],
  }

  file { '/etc/nginx/sites-enabled/default':
    ensure  => absent,
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

  file { '/etc/nginx/conf.d/bluegreen.conf':
    ensure  => file,
    content => epp('baseline/bluegreen.conf.epp', {
      'web_root'     => $web_root,
      'blue_port'    => $blue_port,
      'green_port'   => $green_port,
      'active_port'  => $active_port,
      'active_color' => $active_color,
    }),
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

  service { 'nginx':
    ensure  => running,
    enable  => true,
    require => Package['nginx'],
  }
}
