$myconfig =  @("ELKCONFIG"/L)
input {
  beats {
    port => 5043
  }
}
output {
  elasticsearch {
    hosts => "172.16.10.40:9200"
    manage_template => false
    index => "%{[@metadata][beat]}-%{+YYYY.MM.dd}"
    document_type => "%{[@metadata][type]}"
  }
  stdout { codec => rubydebug }
}
| ELKCONFIG

  class { 'elasticsearch':
    manage_repo  => true,
    repo_version => '5.x',
    restart_on_change => true,
  }

  elasticsearch::instance { 'es-01':
    config => {
      'network.host' => '172.16.10.40',
    },
  }

  class { 'logstash':
    settings => {
      'http.host' => '172.16.10.40',
    }
  }

  logstash::configfile { '02-beats-input.conf':
    content => $myconfig,
  }

  logstash::plugin { 'logstash-input-beats': }

  class { 'kibana' :
    config => {
      'server.host'       =>  '172.16.10.40',
      'elasticsearch.url' => 'http://172.16.10.40:9200',
      'server.port'       => '5601',
    }
  }

  class { 'filebeat':
    outputs => {
      'logstash' => {
        'hosts' => [
          '172.16.10.40:5044',
        ],
        'index' => 'filebeat',
      },
    },
  }

  filebeat::prospector { 'syslogs':
    paths => [
      '/var/log/auth.log',
      '/var/log/syslog',
    ],
    doc_type => 'syslog-beat',
}
