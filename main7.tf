terraform {
  required_providers {
    vultr = {
      source  = "vultr/vultr"
    }
  }
}

provider "vultr" {
  api_key = "SILLVA2A6J3F6S4SKKSNXAPFNZFMWNFF2MRA"
}

resource "vultr_instance" "example" {
  label  = "thomas-vm"
  plan   = "vc2-1c-1gb"  
  region = "fra"       
  image_id  = "docker"

  user_data = <<-EOT
              #!/bin/bash
              apt-get update -y
              curl -fsSL https://get.docker.com/ -o get-docker.sh
              sh get-docker.sh
              usermod -aG docker $USER
              systemctl start docker
              systemctl enable docker
          docker run -d -p 80:80 -e node=Server  jialezi/html5-speedtest
              EOT
}

output "instance_ip" {
  value = vultr_instance.example.main_ip
}
