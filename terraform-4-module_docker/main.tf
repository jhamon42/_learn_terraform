variable "ssh_host" {}
variable "ssh_user" {}
variable "ssh_key" {}

module "docker_install" {
  source = "./modules/docker_install"
  ssh_host = var.ssh_host
  ssh_user = var.ssh_user
  ssh_key = var.ssh_key
}

module "docker_init_nginx" {
  source = "./modules/docker_init_nginx"
  ssh_host = var.ssh_host
}