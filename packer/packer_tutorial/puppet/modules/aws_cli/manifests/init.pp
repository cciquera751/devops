class aws_cli {
  $awscli_version = '2.13.10'
  $awscli_install_dir = '/usr/local/aws-cli'

  file { $awscli_install_dir:
    ensure => directory,
  }

  exec { 'download_awscli':
    command => "curl -o /tmp/awscliv2.zip https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${awscli_version}.zip",
    creates => "/tmp/awscliv2.zip",
    path    => '/usr/bin:/usr/sbin:/bin:/sbin',
  }

  exec { 'unzip_awscli':
    command  => "unzip /tmp/awscliv2.zip -d ${awscli_install_dir}",
    creates  => "${awscli_install_dir}/aws",
    path     => '/usr/bin:/usr/sbin:/bin:/sbin',
    require  => Exec['download_awscli'],
  }

  exec { 'install_awscli':
    command => "sudo ${awscli_install_dir}/aws/install",
    creates => "${awscli_install_dir}/v2",
    path    => '/usr/bin:/usr/sbin:/bin:/sbin', 
    require => Exec['unzip_awscli'],
  }

  file { '/etc/profile.d/awscli.sh':
    ensure  => file,
    content => "export PATH=${awscli_install_dir}:\$PATH",
    require => Exec['install_awscli'],
  }
}
