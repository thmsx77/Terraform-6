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
  label  = "wordpress-vm"
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
              docker network create wordpress-network
              docker run -d --network wordpress-network --name mysql-wordpress -e MYSQL_ROOT_PASSWORD=my-secret-pw -e MYSQL_DATABASE=wordpress -e MYSQL_USER=wordpress -e MYSQL_PASSWORD=wordpress-pw mysql:latest
              docker run -d --network wordpress-network -p 80:80 --name wordpress -e WORDPRESS_DB_HOST=mysql-wordpress -e WORDPRESS_DB_USER=wordpress -e WORDPRESS_DB_PASSWORD=wordpress-pw -e WORDPRESS_DB_NAME=wordpress wordpress:latest
            EOT
}

output "instance_ip" {
  value = vultr_instance.example.main_ip
}
