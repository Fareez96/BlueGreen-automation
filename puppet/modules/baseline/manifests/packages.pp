class baseline::packages {
  package { ['nginx', 'curl', 'python3']:
    ensure => installed,
  }
}
