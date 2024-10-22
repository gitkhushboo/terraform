<<<<<<< HEAD

resource "null_resource" "example" {
  provisioner "local-exec" {
    command = <<EOT
      echo "String Variable: ${var.string_variable}"
      echo "Number Variable: ${var.number_variable}"
      echo "Boolean Variable: ${var.bool_variable}"

      echo "List Variable: ${join(",", var.list_variable)}"
      echo "Map Variable: ${jsonencode(var.map_variable)}"
      echo "Object Variable: Name=${var.object_variable.name}, Age=${var.object_variable.age}"
    EOT
  }
}

=======
module "a1" {
  source = "./config"
  f1s    = "xyz.txt"
  r1s    = 10
}
module "a2" {
  source = "./config"
  f1s    = "klm.txt"
  r1s    = 30
}
>>>>>>> aaee57ae6e70e04b2be8067a2a1f8096b96ffbb4
