resource "null_resource" "ssh_target" {
  connection {
    type = "ssh"
    user = var.ssh_user
    host = var.ssh_host
    private_key = file(var.ssh_key)
  }
  provisioner "remote-exec" {
    inline = [
      "sudo mkdir -p /srv/wordpress/",
      "sudo chmod 777 -R /srv/wordpress/",
      "sleep 5s"
    ]
  }
}

provider "docker" {
  host = "tcp://${var.ssh_host}:2375"
}

resource "docker_volume" "db" {
  name = "db"
  driver = "local"
  driver_opts = {
    o = "bind"
    type = "none"
    device = "/srv/wordpress/"
  }
  depends_on = [
    null_resource.ssh_target
  ]
}

resource "docker_network" "wordpress_net" {
  name = "wordpress_net"
  # driver = "bridge"
  # ipam_config {
  #   subnet = "177.22.0.0/24"
  # }
}

resource "docker_image" "mysql" {
  name = "mysql:5.7"
}

resource "docker_container" "mysql" {
  name  = "mysql"
  image = docker_image.mysql.image_id
  restart = "always"
  env = [
    "MYSQL_ROOT_PASSWORD=wordpress",
    "MYSQL_PASSWORD=wordpress",
    "MYSQL_USER=wordpress",
    "MYSQL_DATABASE=wordpress"
  ]
  networks_advanced {
    name = docker_network.wordpress.name
  }
  volumes {
    host_path = "/svr/wordpress/"
    container_path = "/var/lib/mysql/"
    volume_name = "db"
  }
}

resource "docker_image" "wordpress" {
  name = "wordpress:latest"
}

resource "docker_container" "wordpress" {
  name  = "wordpress"
  image = docker_image.wordpress.image_id
  restart = "always"
  networks_advanced {
    name = docker_network.wordpress.name
  }
  env = [
    "WORDPRESS_DB_USER=wordpress",
    "WORDPRESS_DB_HOST=vol_db:3306",
    "WORDPRESS_DB_PASSWORD=wordpress"
  ]
  ports {
    internal = 80
    external = var.wordpress_port
  }
}