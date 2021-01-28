# ---------------------------
# FEVO NETWORKING MODULE MAIN
# ---------------------------

resource "aws_vpc" "vpc" {
  cidr_block = var.cidr[0]

  tags = merge(
    {
      "Name" = format("%s", var.envrname)
    },
    var.tags,
    var.vpc_tags,
  )
}

resource "aws_vpc_ipv4_cidr_block_association" "this" {
  count      = length(var.cidr) - 1
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.cidr[count.index + 1]
}

# -----------
# VPC SUBNETS
# -----------

// APPAdmin Subnet
resource "aws_subnet" "appadmin_subnet" {
  vpc_id               = aws_vpc.vpc.id
  count                = length(var.appadmin_subnets)
  cidr_block           = element(concat(var.appadmin_subnets, [""]), count.index)
  availability_zone    = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) > 0 ? element(var.azs, count.index) : null
  availability_zone_id = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) == 0 ? element(var.azs, count.index) : null

  tags = merge(
    {
      "Name" = format(
        "%s-${var.appadmin_subnet_suffix}-%s",
        var.envrname,
        element(var.azs, count.index),
      )
    },
    var.tags,
    var.appadmin_subnet_tags,
  )
}

// PRODMAN Subnet
resource "aws_subnet" "prodman_subnet" {
  vpc_id               = aws_vpc.vpc.id
  count                = length(var.prodman_subnets)
  cidr_block           = element(concat(var.prodman_subnets, [""]), count.index)
  availability_zone    = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) > 0 ? element(var.azs, count.index) : null
  availability_zone_id = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) == 0 ? element(var.azs, count.index) : null

  tags = merge(
    {
      "Name" = format(
        "%s-${var.prodman_subnet_suffix}-%s",
        var.envrname,
        element(var.azs, count.index),
      )
    },
    var.tags,
    var.prodman_subnet_tags,
  )

  depends_on = [
    aws_vpc_ipv4_cidr_block_association.this
  ]
}

// QAMAN Subnet
resource "aws_subnet" "qaman_subnet" {
  vpc_id               = aws_vpc.vpc.id
  count                = length(var.qaman_subnets)
  cidr_block           = element(concat(var.qaman_subnets, [""]), count.index)
  availability_zone    = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) > 0 ? element(var.azs, count.index) : null
  availability_zone_id = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) == 0 ? element(var.azs, count.index) : null

  tags = merge(
    {
      "Name" = format(
        "%s-${var.qaman_subnet_suffix}-%s",
        var.envrname,
        element(var.azs, count.index),
      )
    },
    var.tags,
    var.qaman_subnet_tags,
  )

  depends_on = [
    aws_vpc_ipv4_cidr_block_association.this
  ]
}

// DEVMAN Subnet
resource "aws_subnet" "devman_subnet" {
  vpc_id               = aws_vpc.vpc.id
  count                = length(var.devman_subnets)
  cidr_block           = element(concat(var.devman_subnets, [""]), count.index)
  availability_zone    = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) > 0 ? element(var.azs, count.index) : null
  availability_zone_id = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) == 0 ? element(var.azs, count.index) : null

  tags = merge(
    {
      "Name" = format(
        "%s-${var.devman_subnet_suffix}-%s",
        var.envrname,
        element(var.azs, count.index),
      )
    },
    var.tags,
    var.devman_subnet_tags,
  )

  depends_on = [
    aws_vpc_ipv4_cidr_block_association.this
  ]
}

###################
# Security Group
###################
resource "aws_security_group" "app" {
  name        = "Security Group ${var.name[0]}"
  description = "SG Ingress for ${var.name[0]}"
  vpc_id      = aws_vpc.vpc.id

  tags = merge(
    {
      "Name" = format("%sSG ${var.name[0]}", var.envrname)
    },
    var.tags,
    var.appadmin_security_group_tags,
  )

}

resource "aws_security_group_rule" "appadmin_ingress_rules" {
  count = length(var.appadmin_ingress_rules)

  type              = "ingress"
  from_port         = var.appadmin_ingress_rules[count.index].from_port
  to_port           = var.appadmin_ingress_rules[count.index].to_port
  protocol          = var.appadmin_ingress_rules[count.index].protocol
  cidr_blocks       = [var.appadmin_ingress_rules[count.index].cidr_block]
  description       = var.appadmin_ingress_rules[count.index].description
  security_group_id = aws_security_group.app.id
}

resource "aws_security_group_rule" "appadmin_egress_rules" {
  count = length(var.appadmin_egress_rules)

  type              = "egress"
  from_port         = var.appadmin_egress_rules[count.index].from_port
  to_port           = var.appadmin_egress_rules[count.index].to_port
  protocol          = var.appadmin_egress_rules[count.index].protocol
  cidr_blocks       = [var.appadmin_egress_rules[count.index].cidr_block]
  description       = var.appadmin_egress_rules[count.index].description
  security_group_id = aws_security_group.app.id
}


resource "aws_security_group" "prod" {
  name        = "Security Group ${var.name[1]}"
  description = "SG Ingress for ${var.name[1]}"
  vpc_id      = aws_vpc.vpc.id

  tags = merge(
    {
      "Name" = format("%sSG ${var.name[1]}", var.envrname)
    },
    var.tags,
    var.prodman_security_group_tags,
  )

}

resource "aws_security_group_rule" "prodman_ingress_rules" {
  count = length(var.prodman_ingress_rules)

  type              = "ingress"
  from_port         = var.prodman_ingress_rules[count.index].from_port
  to_port           = var.prodman_ingress_rules[count.index].to_port
  protocol          = var.prodman_ingress_rules[count.index].protocol
  cidr_blocks       = [var.prodman_ingress_rules[count.index].cidr_block]
  description       = var.prodman_ingress_rules[count.index].description
  security_group_id = aws_security_group.prod.id
}

resource "aws_security_group_rule" "prodman_egress_rules" {
  count = length(var.prodman_egress_rules)

  type              = "egress"
  from_port         = var.prodman_egress_rules[count.index].from_port
  to_port           = var.prodman_egress_rules[count.index].to_port
  protocol          = var.prodman_egress_rules[count.index].protocol
  cidr_blocks       = [var.prodman_egress_rules[count.index].cidr_block]
  description       = var.prodman_egress_rules[count.index].description
  security_group_id = aws_security_group.prod.id
}

resource "aws_security_group" "qa" {
  name        = "Security Group QA"
  description = "SG Ingress for QA"
  vpc_id      = aws_vpc.vpc.id

  tags = merge(
    {
      "Name" = format("%sSG QA ", var.envrname)
    },
    var.tags,
    var.qaman_security_group_tags,
  )

}

resource "aws_security_group_rule" "qaman_ingress_rules" {
  count = length(var.qaman_ingress_rules)

  type              = "ingress"
  from_port         = var.qaman_ingress_rules[count.index].from_port
  to_port           = var.qaman_ingress_rules[count.index].to_port
  protocol          = var.qaman_ingress_rules[count.index].protocol
  cidr_blocks       = [var.qaman_ingress_rules[count.index].cidr_block]
  description       = var.qaman_ingress_rules[count.index].description
  security_group_id = aws_security_group.qa.id
}

resource "aws_security_group_rule" "qaman_egress_rules" {
  count = length(var.qaman_egress_rules)

  type              = "egress"
  from_port         = var.qaman_egress_rules[count.index].from_port
  to_port           = var.qaman_egress_rules[count.index].to_port
  protocol          = var.qaman_egress_rules[count.index].protocol
  cidr_blocks       = [var.qaman_egress_rules[count.index].cidr_block]
  description       = var.qaman_egress_rules[count.index].description
  security_group_id = aws_security_group.qa.id
}

resource "aws_security_group" "dev" {
  name        = "Security Group ${var.name[2]}"
  description = "SG Ingress for ${var.name[2]}"
  vpc_id      = aws_vpc.vpc.id

  tags = merge(
    {
      "Name" = format("%sSG ${var.name[2]}", var.envrname)
    },
    var.tags,
    var.devman_security_group_tags,
  )

}
resource "aws_security_group_rule" "devman_ingress_rules" {
  count = length(var.devman_ingress_rules)

  type              = "ingress"
  from_port         = var.devman_ingress_rules[count.index].from_port
  to_port           = var.devman_ingress_rules[count.index].to_port
  protocol          = var.devman_ingress_rules[count.index].protocol
  cidr_blocks       = [var.devman_ingress_rules[count.index].cidr_block]
  description       = var.devman_ingress_rules[count.index].description
  security_group_id = aws_security_group.dev.id
}

resource "aws_security_group_rule" "devman_egress_rules" {
  count = length(var.devman_egress_rules)

  type              = "egress"
  from_port         = var.devman_egress_rules[count.index].from_port
  to_port           = var.devman_egress_rules[count.index].to_port
  protocol          = var.devman_egress_rules[count.index].protocol
  cidr_blocks       = [var.devman_egress_rules[count.index].cidr_block]
  description       = var.devman_egress_rules[count.index].description
  security_group_id = aws_security_group.dev.id
}

###################
# ACL
###################

//APP ACL + Associate APP Subnets

resource "aws_network_acl" "aclapp" {
  count = length(var.prodman_subnets) > 0 ? 1 : 0

  vpc_id     = aws_vpc.vpc.id
  subnet_ids = aws_subnet.appadmin_subnet.*.id

  tags = merge(
    {
      "Name" = format("%s-${var.appadmin_subnet_suffix}", var.envrname)
    },
    var.tags,
    var.appadmin_acl_tags,
  )
}
// Create Engress/Ingress rules:
resource "aws_network_acl_rule" "appadmin_inbound" {
  count = length(var.appadmin_subnets) > 0 ? length(var.appadmin_inbound_acl_rules) : 0

  network_acl_id = aws_network_acl.aclapp.*.id

  egress          = false
  rule_number     = var.appadmin_inbound_acl_rules[count.index]["rule_number"]
  rule_action     = var.appadmin_inbound_acl_rules[count.index]["rule_action"]
  from_port       = lookup(var.appadmin_inbound_acl_rules[count.index], "from_port", null)
  to_port         = lookup(var.appadmin_inbound_acl_rules[count.index], "to_port", null)
  icmp_code       = lookup(var.appadmin_inbound_acl_rules[count.index], "icmp_code", null)
  icmp_type       = lookup(var.appadmin_inbound_acl_rules[count.index], "icmp_type", null)
  protocol        = var.appadmin_inbound_acl_rules[count.index]["protocol"]
  cidr_block      = lookup(var.appadmin_inbound_acl_rules[count.index], "cidr_block", null)
  ipv6_cidr_block = lookup(var.appadmin_inbound_acl_rules[count.index], "ipv6_cidr_block", null)
}

resource "aws_network_acl_rule" "appadmin_outbound" {
  count = length(var.appadmin_subnets) > 0 ? length(var.appadmin_outbound_acl_rules) : 0

  network_acl_id = aws_network_acl.aclapp.*.id

  egress          = true
  rule_number     = var.appadmin_outbound_acl_rules[count.index]["rule_number"]
  rule_action     = var.appadmin_outbound_acl_rules[count.index]["rule_action"]
  from_port       = lookup(var.appadmin_outbound_acl_rules[count.index], "from_port", null)
  to_port         = lookup(var.appadmin_outbound_acl_rules[count.index], "to_port", null)
  icmp_code       = lookup(var.appadmin_outbound_acl_rules[count.index], "icmp_code", null)
  icmp_type       = lookup(var.appadmin_outbound_acl_rules[count.index], "icmp_type", null)
  protocol        = var.appadmin_outbound_acl_rules[count.index]["protocol"]
  cidr_block      = lookup(var.appadmin_outbound_acl_rules[count.index], "cidr_block", null)
  ipv6_cidr_block = lookup(var.appadmin_outbound_acl_rules[count.index], "ipv6_cidr_block", null)
}

// PROD ACL
resource "aws_network_acl" "aclprod" {
  count = length(var.prodman_subnets) > 0 ? 1 : 0

  vpc_id     = aws_vpc.vpc.id
  subnet_ids = aws_subnet.prodman_subnet.*.id

  tags = merge(
    {
      "Name" = format("%s-${var.prodman_subnet_suffix}", var.envrname)
    },
    var.tags,
    var.prodman_acl_tags,
  )
}
resource "aws_network_acl_rule" "prodman_inbound" {
  count = length(var.prodman_subnets) > 0 ? length(var.prodman_inbound_acl_rules) : 0

  network_acl_id = aws_network_acl.aclprod[0].id

  egress          = false
  rule_number     = var.prodman_inbound_acl_rules[count.index]["rule_number"]
  rule_action     = var.prodman_inbound_acl_rules[count.index]["rule_action"]
  from_port       = lookup(var.prodman_inbound_acl_rules[count.index], "from_port", null)
  to_port         = lookup(var.prodman_inbound_acl_rules[count.index], "to_port", null)
  icmp_code       = lookup(var.prodman_inbound_acl_rules[count.index], "icmp_code", null)
  icmp_type       = lookup(var.prodman_inbound_acl_rules[count.index], "icmp_type", null)
  protocol        = var.prodman_inbound_acl_rules[count.index]["protocol"]
  cidr_block      = lookup(var.prodman_inbound_acl_rules[count.index], "cidr_block", null)
  ipv6_cidr_block = lookup(var.prodman_inbound_acl_rules[count.index], "ipv6_cidr_block", null)
}

resource "aws_network_acl_rule" "prodman_outbound" {
  count = length(var.prodman_subnets) > 0 ? length(var.prodman_outbound_acl_rules) : 0

  network_acl_id = aws_network_acl.aclprod[0].id

  egress          = true
  rule_number     = var.prodman_outbound_acl_rules[count.index]["rule_number"]
  rule_action     = var.prodman_outbound_acl_rules[count.index]["rule_action"]
  from_port       = lookup(var.prodman_outbound_acl_rules[count.index], "from_port", null)
  to_port         = lookup(var.prodman_outbound_acl_rules[count.index], "to_port", null)
  icmp_code       = lookup(var.prodman_outbound_acl_rules[count.index], "icmp_code", null)
  icmp_type       = lookup(var.prodman_outbound_acl_rules[count.index], "icmp_type", null)
  protocol        = var.prodman_outbound_acl_rules[count.index]["protocol"]
  cidr_block      = lookup(var.prodman_outbound_acl_rules[count.index], "cidr_block", null)
  ipv6_cidr_block = lookup(var.prodman_outbound_acl_rules[count.index], "ipv6_cidr_block", null)
}

// QA ACL
resource "aws_network_acl" "aclqc" {
  count = length(var.qaman_subnets) > 0 ? 1 : 0

  vpc_id     = aws_vpc.vpc.id
  subnet_ids = aws_subnet.qaman_subnet.*.id

  tags = merge(
    {
      "Name" = format("%s-${var.qaman_subnet_suffix}", var.envrname)
    },
    var.tags,
    var.qaman_acl_tags,
  )
}
resource "aws_network_acl_rule" "qaman_inbound" {
  count = length(var.qaman_subnets) > 0 ? length(var.qaman_inbound_acl_rules) : 0

  network_acl_id = aws_network_acl.aclqc[0].id

  egress          = false
  rule_number     = var.qaman_inbound_acl_rules[count.index]["rule_number"]
  rule_action     = var.qaman_inbound_acl_rules[count.index]["rule_action"]
  from_port       = lookup(var.qaman_inbound_acl_rules[count.index], "from_port", null)
  to_port         = lookup(var.qaman_inbound_acl_rules[count.index], "to_port", null)
  icmp_code       = lookup(var.qaman_inbound_acl_rules[count.index], "icmp_code", null)
  icmp_type       = lookup(var.qaman_inbound_acl_rules[count.index], "icmp_type", null)
  protocol        = var.qaman_inbound_acl_rules[count.index]["protocol"]
  cidr_block      = lookup(var.qaman_inbound_acl_rules[count.index], "cidr_block", null)
  ipv6_cidr_block = lookup(var.qaman_inbound_acl_rules[count.index], "ipv6_cidr_block", null)
}

resource "aws_network_acl_rule" "qaman_outbound" {
  count = length(var.qaman_subnets) > 0 ? length(var.qaman_outbound_acl_rules) : 0

  network_acl_id = aws_network_acl.aclqc[0].id

  egress          = true
  rule_number     = var.qaman_outbound_acl_rules[count.index]["rule_number"]
  rule_action     = var.qaman_outbound_acl_rules[count.index]["rule_action"]
  from_port       = lookup(var.qaman_outbound_acl_rules[count.index], "from_port", null)
  to_port         = lookup(var.qaman_outbound_acl_rules[count.index], "to_port", null)
  icmp_code       = lookup(var.qaman_outbound_acl_rules[count.index], "icmp_code", null)
  icmp_type       = lookup(var.qaman_outbound_acl_rules[count.index], "icmp_type", null)
  protocol        = var.qaman_outbound_acl_rules[count.index]["protocol"]
  cidr_block      = lookup(var.qaman_outbound_acl_rules[count.index], "cidr_block", null)
  ipv6_cidr_block = lookup(var.qaman_outbound_acl_rules[count.index], "ipv6_cidr_block", null)
}

// DEV ACL
resource "aws_network_acl" "acldev" {
  count = length(var.devman_subnets) > 0 ? 1 : 0

  vpc_id     = aws_vpc.vpc.id
  subnet_ids = aws_subnet.devman_subnet.*.id

  tags = merge(
    {
      "Name" = format("%s-${var.devman_subnet_suffix}", var.envrname)
    },
    var.tags,
    var.devman_acl_tags,
  )
}
resource "aws_network_acl_rule" "devman_inbound" {
  count = length(var.devman_subnets) > 0 ? length(var.devman_inbound_acl_rules) : 0

  network_acl_id = aws_network_acl.acldev[0].id

  egress          = false
  rule_number     = var.devman_inbound_acl_rules[count.index]["rule_number"]
  rule_action     = var.devman_inbound_acl_rules[count.index]["rule_action"]
  from_port       = lookup(var.devman_inbound_acl_rules[count.index], "from_port", null)
  to_port         = lookup(var.devman_inbound_acl_rules[count.index], "to_port", null)
  icmp_code       = lookup(var.devman_inbound_acl_rules[count.index], "icmp_code", null)
  icmp_type       = lookup(var.devman_inbound_acl_rules[count.index], "icmp_type", null)
  protocol        = var.devman_inbound_acl_rules[count.index]["protocol"]
  cidr_block      = lookup(var.devman_inbound_acl_rules[count.index], "cidr_block", null)
  ipv6_cidr_block = lookup(var.devman_inbound_acl_rules[count.index], "ipv6_cidr_block", null)
}

resource "aws_network_acl_rule" "devman_outbound" {
  count = length(var.devman_subnets) > 0 ? length(var.devman_outbound_acl_rules) : 0

  network_acl_id = aws_network_acl.acldev[0].id

  egress          = true
  rule_number     = var.devman_outbound_acl_rules[count.index]["rule_number"]
  rule_action     = var.devman_outbound_acl_rules[count.index]["rule_action"]
  from_port       = lookup(var.devman_outbound_acl_rules[count.index], "from_port", null)
  to_port         = lookup(var.devman_outbound_acl_rules[count.index], "to_port", null)
  icmp_code       = lookup(var.devman_outbound_acl_rules[count.index], "icmp_code", null)
  icmp_type       = lookup(var.devman_outbound_acl_rules[count.index], "icmp_type", null)
  protocol        = var.devman_outbound_acl_rules[count.index]["protocol"]
  cidr_block      = lookup(var.devman_outbound_acl_rules[count.index], "cidr_block", null)
  ipv6_cidr_block = lookup(var.devman_outbound_acl_rules[count.index], "ipv6_cidr_block", null)
}

# -----------------------------
# VPC Peering Shared Services 1
# -----------------------------

resource "aws_vpc_peering_connection" "default" {
  peer_owner_id = var.shared_services_1_acceptor_account_id
  vpc_id        = aws_vpc.vpc.id
  peer_vpc_id   = data.aws_vpc.shared_services_1_acceptor_vpc_tags.id
  peer_region   = var.shared_services_1_acceptor_region
  auto_accept   = false

  tags = merge(
    {
      "Name" = format("%s${var.shared_services_1_acceptor_peering_name}", var.envrname)
    },
    var.tags,
    var.shared_services_1_acceptor_peering_tags,
  )

  depends_on = [
    aws_vpc_ipv4_cidr_block_association.this
  ]

}

resource "aws_vpc_peering_connection_accepter" "acceptor" {
  provider                  = aws.peer
  vpc_peering_connection_id = aws_vpc_peering_connection.default.id
  auto_accept               = true

  tags = {
    Side = "Accepter"
  }

  depends_on = [
    aws_vpc_ipv4_cidr_block_association.this
  ]

  lifecycle {
    ignore_changes = [auto_accept]
  }

}

# --------------
# ROUTING TABLES
# --------------

# APP Route
resource "aws_route_table" "rtapp" {
  vpc_id = aws_vpc.vpc.id
  count  = length(var.appadmin_subnets)

  route {
    cidr_block                = var.rtsharedservice
    vpc_peering_connection_id = aws_vpc_peering_connection.default.id
  }

  tags = merge(
    {
      "Name"        = format("%s-${var.appadmin_subnet_suffix}-%s", var.envrname, element(var.azs, count.index), )
      "Description" = format("%s-${var.appadmin_subnet_suffix}-%s", var.envrname, element(var.azs, count.index), )
    },
    var.tags,
    var.appadmin_route_table_tags,
  )
}

# PROD Route
resource "aws_route_table" "rtprod" {
  vpc_id = aws_vpc.vpc.id
  count  = length(var.prodman_subnets)

  tags = merge(
    {
      "Name"        = format("%s-${var.prodman_subnet_suffix}-%s", var.envrname, element(var.azs, count.index), )
      "Description" = format("%s-${var.prodman_subnet_suffix}-%s", var.envrname, element(var.azs, count.index), )
    },
    var.tags,
    var.prodman_route_table_tags,
  )
}

# QA Route
resource "aws_route_table" "rtqa" {
  vpc_id = aws_vpc.vpc.id
  count  = length(var.qaman_subnets)

  tags = merge(
    {
      "Name"        = format("%s-${var.qaman_subnet_suffix}-%s", var.envrname, element(var.azs, count.index), )
      "Description" = format("%s-${var.qaman_subnet_suffix}-%s", var.envrname, element(var.azs, count.index), )
    },
    var.tags,
    var.qaman_route_table_tags,
  )
}

# DEV Route
resource "aws_route_table" "rtdev" {
  vpc_id = aws_vpc.vpc.id
  count  = length(var.devman_subnets)

  tags = merge(
    {
      "Name"        = format("%s-${var.devman_subnet_suffix}-%s", var.envrname, element(var.azs, count.index), )
      "Description" = format("%s-${var.devman_subnet_suffix}-%s", var.envrname, element(var.azs, count.index), )
    },
    var.tags,
    var.devman_route_table_tags,
  )
}

### Associate Route Table with Subnet
resource "aws_route_table_association" "app" {
  count          = length(var.appadmin_subnets)
  subnet_id      = aws_subnet.appadmin_subnet[count.index].id
  route_table_id = aws_route_table.rtapp[count.index].id
}

resource "aws_route_table_association" "prod" {
  count          = length(var.prodman_subnets)
  subnet_id      = aws_subnet.prodman_subnet[count.index].id
  route_table_id = aws_route_table.rtprod[count.index].id
}

resource "aws_route_table_association" "qa" {
  count          = length(var.qaman_subnets)
  subnet_id      = aws_subnet.qaman_subnet[count.index].id
  route_table_id = aws_route_table.rtqa[count.index].id
}


resource "aws_route_table_association" "dev" {
  count          = length(var.devman_subnets)
  subnet_id      = aws_subnet.devman_subnet[count.index].id
  route_table_id = aws_route_table.rtdev[count.index].id
}