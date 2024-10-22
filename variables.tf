variable "string_variable" {
  description = "A simple string variable"
  type        = string
}

variable "number_variable" {
  description = "A number variable"
  type        = number
}

variable "bool_variable" {
  description = "A boolean variable"
  type        = bool
}

variable "list_variable" {
  description = "A list of strings"
  type        = list(string)
}

variable "map_variable" {
  description = "A map of strings"
  type        = map(string)
}

variable "object_variable" {
  description = "An object variable"
  type = object({
    name = string
    age  = number
  })
}

