variable "name" {}

variable "vpc" {
  type = object({
    id              = string
    cidr_block      = string
    ipv6_cidr_block = string
  })
}

variable "routes" {
  type = map(object({
    cidr_block                = optional(string)
    ipv6_cidr_block           = optional(string)
    gateway_id                = optional(string)
    nat_gateway_id            = optional(string)
    vpc_peering_connection_id = optional(string)
    network_interface_id      = optional(string)
    instance_id               = optional(string)
  }))
  default = {}
}

variable "tags" {
  type    = map(string)
  default = {}
}