resource "local_file" "f1" {
  filename = var.f1s
  content  = random_string.r1.id
}

resource "random_string" "r1" {
  length = var.r1s
}

variable "r1s" {
  default = 15
  type    = number
}
variable "f1s" {
  default = "abc"
  type    = string
}
