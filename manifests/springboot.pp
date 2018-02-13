class { "java":
    package => "java-1.8.0-openjdk",
}

exec { 'start springboot':
    command => 'nohup /usr/bin/java -jar /vagrant/packages/helloworld-springboot-0.0.1-SNAPSHOT.jar >> /var/log/springboot.log 2>&1 &',
    path => ['/usr/bin', '/bin', '/usr/sbin', '/sbin', '/usr/local/bin', '/usr/local/sbin']
}
