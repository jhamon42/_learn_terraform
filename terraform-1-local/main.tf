
variable "str" {
  type = string
  default = "+"
}

variable "hosts" {
  type = map
  default = {
    "127.0.0.1" = "localhost gitlab.local"
    "192.169.1.168" = "gitlab.test"
    "192.169.1.170" = "prometheus.test"
  }
}

variable "foo" {
  type = list
  default = ["127.0.0.1", "192.169.1.168", "192.169.1.170"]
}

resource "null_resource" "node1" {
  for_each = var.hosts
  provisioner "local-exec" {
    command = "echo '${var.str} ${each.key} ${each.value}' >> hosts.txt"
  }
}

resource "null_resource" "name" {
  count = "${length(var.foo)}"
  provisioner "local-exec" {
    command = "echo '${element(var.foo, count.index)}' >> ip.txt"
  }
}
