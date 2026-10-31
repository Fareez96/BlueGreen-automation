class baseline (
  String  $web_root   = '/var/www',
  Integer $blue_port  = 8081,
  Integer $green_port = 8082,
) {
  contain baseline::packages
  contain baseline::ssh
  contain baseline::nginx

  Class['baseline::packages'] -> Class['baseline::nginx']
}
