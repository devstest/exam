class profile::nginx {
  class { 'nginx':
    manage_repo => true,
    package_source => 'nginx-mainline'
  }

  nginx::resource::upstream { 'helloworld':
    members => [
        '172.16.10.20:8080',
        '172.16.10.30:8080',
    ],
  }

  nginx::resource::server { 'nginx.vagrant.wm':
    proxy => 'http://helloworld',
  }
}
