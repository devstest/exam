class profile::haproxy {
    class { '::haproxy': }

    haproxy::listen { 'springboot':
       ipaddress => $::ipaddress_eth1,
       ports     => '80',
       mode      => 'http',
       options   => {
         'option'  => ['httplog'],
         'balance' => 'roundrobin',
       },
    }

    haproxy::balancermember { 'haproxy':
        listening_service => 'springboot',
        ports             => '8080',
        server_names      => ['springboot1', 'springboot2'],
        ipaddresses       => ['172.16.10.20', '172.16.10.30'],
        options           => 'check',
    }

    haproxy::listen { 'stats':
       ipaddress => $::ipaddress_eth1,
       ports     => '9090',
       options   => {
          'mode'  => 'http',
          'stats' => ['uri /', 'auth haproxy:haproxy']
       },
    }

    firewall { '110 allow haproxy stats':
       port   => [9090],
       proto  => 'tcp',
       action => 'accept',
    }
}
