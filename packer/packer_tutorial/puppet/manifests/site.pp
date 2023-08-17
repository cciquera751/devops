node 'default' {
  package { 'unzip':
    ensure => present,
  }
  package { 'zip':
    ensure => present,
  }

  # Install the AWS CLI
  include aws_cli

}
