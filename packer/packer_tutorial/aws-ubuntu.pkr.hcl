packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
    puppet = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/puppet"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "learn-packer-linux-aws"
  instance_type = "t2.micro"
  region        = "us-east-2"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}

build {
  name    = "learn-packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]
  
  provisioner "shell" {
    inline = [
      "sudo -E echo 'deb https://deb.gremlin.com/ release non-free' | sudo tee  /etc/apt/sources.list.d/gremlin.list",
      "sudo -E APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1 apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 9CDB294B29A5B1E2E00C24C022E8EF3461A50EF6",
      "sudo DEBIAN_FRONTEND=noninteractive apt-get -y update",
      "sudo DEBIAN_FRONTEND=noninteractive apt-get -y install --allow-unauthenticated python3-requests",
      "sudo DEBIAN_FRONTEND=noninteractive apt-get -y install python3-pip",
      "sudo pip3 install --upgrade pip",
      "sudo pip3 install setuptools",
      "sudo mkdir -p /tmp/cfn-helper-scripts/aws-cfn-bootstrap-latest",
      "sudo pip3 install https://s3.amazonaws.com/cloudformation-examples/aws-cfn-bootstrap-py3-latest.tar.gz",
      "sudo snap refresh amazon-ssm-agent"
  ]
 
  provisioner "shell" {
    inline = [
      
    ]
  }

  }
}
