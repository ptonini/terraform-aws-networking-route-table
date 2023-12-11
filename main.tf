resource "aws_route_table" "this" {
  vpc_id = var.vpc.id

  route {
    cidr_block = var.vpc.cidr_block
    gateway_id = "local"
  }

  route {
    ipv6_cidr_block = var.vpc.ipv6_cidr_block
    gateway_id      = "local"
  }

  dynamic "route" {
    for_each = var.routes
    content {
      cidr_block                = route.value.cidr_block
      ipv6_cidr_block           = route.value.ipv6_cidr_block
      gateway_id                = route.value.gateway_id
      nat_gateway_id            = route.value.nat_gateway_id
      vpc_peering_connection_id = route.value.connection_id
      network_interface_id      = route.value.network_interface_id
    }
  }

  tags = merge(var.tags, {
    Name = var.name
  })

  lifecycle {
    ignore_changes = [
      tags["business_unit"],
      tags["product"],
      tags["env"],
      tags_all
    ]
  }
}

resource "aws_main_route_table_association" "this" {
  count          = var.main_route_table ? 1 : 0
  vpc_id         = var.vpc.id
  route_table_id = aws_route_table.this
}