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
