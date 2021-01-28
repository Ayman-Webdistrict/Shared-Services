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

// APPMAN Subnet
resource "aws_subnet" "app_subnet" {
  vpc_id               = aws_vpc.vpc.id
  count                = length(var.app_subnets)
  cidr_block           = element(concat(var.app_subnets, [""]), count.index)
  availability_zone    = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) > 0 ? element(var.azs, count.index) : null
  availability_zone_id = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) == 0 ? element(var.azs, count.index) : null

  tags = merge(
    {
      "Name" = format(
        "%s-${var.app_subnet_suffix}-%s",
        var.envrname,
        element(var.azs, count.index),
      )
    },
    var.tags,
    var.app_subnet_tags,
  )
}

// PRODMAN Subnet
resource "aws_subnet" "prod_subnet" {
  vpc_id               = aws_vpc.vpc.id
  count                = length(var.prod_subnets)
  cidr_block           = element(concat(var.prod_subnets, [""]), count.index)
  availability_zone    = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) > 0 ? element(var.azs, count.index) : null
  availability_zone_id = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) == 0 ? element(var.azs, count.index) : null

  tags = merge(
    {
      "Name" = format(
        "%s-${var.prod_subnet_suffix}-%s",
        var.envrname,
        element(var.azs, count.index),
      )
    },
    var.tags,
    var.prod_subnet_tags,
  )

  depends_on = [
    aws_vpc_ipv4_cidr_block_association.this
  ]
}

// QAMAN Subnet
resource "aws_subnet" "qa_subnet" {
  vpc_id               = aws_vpc.vpc.id
  count                = length(var.qa_subnets)
  cidr_block           = element(concat(var.qa_subnets, [""]), count.index)
  availability_zone    = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) > 0 ? element(var.azs, count.index) : null
  availability_zone_id = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) == 0 ? element(var.azs, count.index) : null

  tags = merge(
    {
      "Name" = format(
        "%s-${var.qa_subnet_suffix}-%s",
        var.envrname,
        element(var.azs, count.index),
      )
    },
    var.tags,
    var.qa_subnet_tags,
  )

  depends_on = [
    aws_vpc_ipv4_cidr_block_association.this
  ]
}

// DEVMAN Subnet
resource "aws_subnet" "dev_subnet" {
  vpc_id               = aws_vpc.vpc.id
  count                = length(var.dev_subnets)
  cidr_block           = element(concat(var.dev_subnets, [""]), count.index)
  availability_zone    = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) > 0 ? element(var.azs, count.index) : null
  availability_zone_id = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) == 0 ? element(var.azs, count.index) : null

  tags = merge(
    {
      "Name" = format(
        "%s-${var.dev_subnet_suffix}-%s",
        var.envrname,
        element(var.azs, count.index),
      )
    },
    var.tags,
    var.dev_subnet_tags,
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
    var.app_security_group_tags,
  )

}

resource "aws_security_group_rule" "app_ingress_rules" {
  count = length(var.app_ingress_rules)

  type              = "ingress"
  from_port         = var.app_ingress_rules[count.index].from_port
  to_port           = var.app_ingress_rules[count.index].to_port
  protocol          = var.app_ingress_rules[count.index].protocol
  cidr_blocks       = [var.app_ingress_rules[count.index].cidr_block]
  description       = var.app_ingress_rules[count.index].description
  security_group_id = aws_security_group.app.id
}

resource "aws_security_group_rule" "app_egress_rules" {
  count = length(var.app_egress_rules)

  type              = "egress"
  from_port         = var.app_egress_rules[count.index].from_port
  to_port           = var.app_egress_rules[count.index].to_port
  protocol          = var.app_egress_rules[count.index].protocol
  cidr_blocks       = [var.app_egress_rules[count.index].cidr_block]
  description       = var.app_egress_rules[count.index].description
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
    var.prod_security_group_tags,
  )

}

resource "aws_security_group_rule" "prod_ingress_rules" {
  count = length(var.prod_ingress_rules)

  type              = "ingress"
  from_port         = var.prod_ingress_rules[count.index].from_port
  to_port           = var.prod_ingress_rules[count.index].to_port
  protocol          = var.prod_ingress_rules[count.index].protocol
  cidr_blocks       = [var.prod_ingress_rules[count.index].cidr_block]
  description       = var.prod_ingress_rules[count.index].description
  security_group_id = aws_security_group.prod.id
}

resource "aws_security_group_rule" "prod_egress_rules" {
  count = length(var.prod_egress_rules)

  type              = "egress"
  from_port         = var.prod_egress_rules[count.index].from_port
  to_port           = var.prod_egress_rules[count.index].to_port
  protocol          = var.prod_egress_rules[count.index].protocol
  cidr_blocks       = [var.prod_egress_rules[count.index].cidr_block]
  description       = var.prod_egress_rules[count.index].description
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
    var.qa_security_group_tags,
  )

}

resource "aws_security_group_rule" "qa_ingress_rules" {
  count = length(var.qa_ingress_rules)

  type              = "ingress"
  from_port         = var.qa_ingress_rules[count.index].from_port
  to_port           = var.qa_ingress_rules[count.index].to_port
  protocol          = var.qa_ingress_rules[count.index].protocol
  cidr_blocks       = [var.qa_ingress_rules[count.index].cidr_block]
  description       = var.qa_ingress_rules[count.index].description
  security_group_id = aws_security_group.qa.id
}

resource "aws_security_group_rule" "qa_egress_rules" {
  count = length(var.qa_egress_rules)

  type              = "egress"
  from_port         = var.qa_egress_rules[count.index].from_port
  to_port           = var.qa_egress_rules[count.index].to_port
  protocol          = var.qa_egress_rules[count.index].protocol
  cidr_blocks       = [var.qa_egress_rules[count.index].cidr_block]
  description       = var.qa_egress_rules[count.index].description
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
    var.dev_security_group_tags,
  )

}
resource "aws_security_group_rule" "dev_ingress_rules" {
  count = length(var.dev_ingress_rules)

  type              = "ingress"
  from_port         = var.dev_ingress_rules[count.index].from_port
  to_port           = var.dev_ingress_rules[count.index].to_port
  protocol          = var.dev_ingress_rules[count.index].protocol
  cidr_blocks       = [var.dev_ingress_rules[count.index].cidr_block]
  description       = var.dev_ingress_rules[count.index].description
  security_group_id = aws_security_group.dev.id
}

resource "aws_security_group_rule" "dev_egress_rules" {
  count = length(var.dev_egress_rules)

  type              = "egress"
  from_port         = var.dev_egress_rules[count.index].from_port
  to_port           = var.dev_egress_rules[count.index].to_port
  protocol          = var.dev_egress_rules[count.index].protocol
  cidr_blocks       = [var.dev_egress_rules[count.index].cidr_block]
  description       = var.dev_egress_rules[count.index].description
  security_group_id = aws_security_group.dev.id
}

###################
# ACL
###################

//APP ACL + Associate APP Subnets

resource "aws_network_acl" "aclapp" {
  count = length(var.prod_subnets) > 0 ? 1 : 0

  vpc_id     = aws_vpc.vpc.id
  subnet_ids = aws_subnet.app_subnet.*.id

  tags = merge(
    {
      "Name" = format("%s-${var.app_subnet_suffix}", var.envrname)
    },
    var.tags,
    var.app_acl_tags,
  )
}
// Create Engress/Ingress rules:
resource "aws_network_acl_rule" "app_inbound" {
  count = length(var.app_subnets) > 0 ? length(var.app_inbound_acl_rules) : 0

  network_acl_id = aws_network_acl.aclapp.*.id

  egress          = false
  rule_number     = var.app_inbound_acl_rules[count.index]["rule_number"]
  rule_action     = var.app_inbound_acl_rules[count.index]["rule_action"]
  from_port       = lookup(var.app_inbound_acl_rules[count.index], "from_port", null)
  to_port         = lookup(var.app_inbound_acl_rules[count.index], "to_port", null)
  icmp_code       = lookup(var.app_inbound_acl_rules[count.index], "icmp_code", null)
  icmp_type       = lookup(var.app_inbound_acl_rules[count.index], "icmp_type", null)
  protocol        = var.app_inbound_acl_rules[count.index]["protocol"]
  cidr_block      = lookup(var.app_inbound_acl_rules[count.index], "cidr_block", null)
  ipv6_cidr_block = lookup(var.app_inbound_acl_rules[count.index], "ipv6_cidr_block", null)
}

resource "aws_network_acl_rule" "app_outbound" {
  count = length(var.app_subnets) > 0 ? length(var.app_outbound_acl_rules) : 0

  network_acl_id = aws_network_acl.aclapp.*.id

  egress          = true
  rule_number     = var.app_outbound_acl_rules[count.index]["rule_number"]
  rule_action     = var.app_outbound_acl_rules[count.index]["rule_action"]
  from_port       = lookup(var.app_outbound_acl_rules[count.index], "from_port", null)
  to_port         = lookup(var.app_outbound_acl_rules[count.index], "to_port", null)
  icmp_code       = lookup(var.app_outbound_acl_rules[count.index], "icmp_code", null)
  icmp_type       = lookup(var.app_outbound_acl_rules[count.index], "icmp_type", null)
  protocol        = var.app_outbound_acl_rules[count.index]["protocol"]
  cidr_block      = lookup(var.app_outbound_acl_rules[count.index], "cidr_block", null)
  ipv6_cidr_block = lookup(var.app_outbound_acl_rules[count.index], "ipv6_cidr_block", null)
}

// PROD ACL
resource "aws_network_acl" "aclprod" {
  count = length(var.prod_subnets) > 0 ? 1 : 0

  vpc_id     = aws_vpc.vpc.id
  subnet_ids = aws_subnet.prod_subnet.*.id

  tags = merge(
    {
      "Name" = format("%s-${var.prod_subnet_suffix}", var.envrname)
    },
    var.tags,
    var.prod_acl_tags,
  )
}
resource "aws_network_acl_rule" "prod_inbound" {
  count = length(var.prod_subnets) > 0 ? length(var.prod_inbound_acl_rules) : 0

  network_acl_id = aws_network_acl.aclprod[0].id

  egress          = false
  rule_number     = var.prod_inbound_acl_rules[count.index]["rule_number"]
  rule_action     = var.prod_inbound_acl_rules[count.index]["rule_action"]
  from_port       = lookup(var.prod_inbound_acl_rules[count.index], "from_port", null)
  to_port         = lookup(var.prod_inbound_acl_rules[count.index], "to_port", null)
  icmp_code       = lookup(var.prod_inbound_acl_rules[count.index], "icmp_code", null)
  icmp_type       = lookup(var.prod_inbound_acl_rules[count.index], "icmp_type", null)
  protocol        = var.prod_inbound_acl_rules[count.index]["protocol"]
  cidr_block      = lookup(var.prod_inbound_acl_rules[count.index], "cidr_block", null)
  ipv6_cidr_block = lookup(var.prod_inbound_acl_rules[count.index], "ipv6_cidr_block", null)
}

resource "aws_network_acl_rule" "prod_outbound" {
  count = length(var.prod_subnets) > 0 ? length(var.prod_outbound_acl_rules) : 0

  network_acl_id = aws_network_acl.aclprod[0].id

  egress          = true
  rule_number     = var.prod_outbound_acl_rules[count.index]["rule_number"]
  rule_action     = var.prod_outbound_acl_rules[count.index]["rule_action"]
  from_port       = lookup(var.prod_outbound_acl_rules[count.index], "from_port", null)
  to_port         = lookup(var.prod_outbound_acl_rules[count.index], "to_port", null)
  icmp_code       = lookup(var.prod_outbound_acl_rules[count.index], "icmp_code", null)
  icmp_type       = lookup(var.prod_outbound_acl_rules[count.index], "icmp_type", null)
  protocol        = var.prod_outbound_acl_rules[count.index]["protocol"]
  cidr_block      = lookup(var.prod_outbound_acl_rules[count.index], "cidr_block", null)
  ipv6_cidr_block = lookup(var.prod_outbound_acl_rules[count.index], "ipv6_cidr_block", null)
}

// QA ACL
resource "aws_network_acl" "aclqc" {
  count = length(var.qa_subnets) > 0 ? 1 : 0

  vpc_id     = aws_vpc.vpc.id
  subnet_ids = aws_subnet.qa_subnet.*.id

  tags = merge(
    {
      "Name" = format("%s-${var.qa_subnet_suffix}", var.envrname)
    },
    var.tags,
    var.qa_acl_tags,
  )
}
resource "aws_network_acl_rule" "qa_inbound" {
  count = length(var.qa_subnets) > 0 ? length(var.qa_inbound_acl_rules) : 0

  network_acl_id = aws_network_acl.aclqc[0].id

  egress          = false
  rule_number     = var.qa_inbound_acl_rules[count.index]["rule_number"]
  rule_action     = var.qa_inbound_acl_rules[count.index]["rule_action"]
  from_port       = lookup(var.qa_inbound_acl_rules[count.index], "from_port", null)
  to_port         = lookup(var.qa_inbound_acl_rules[count.index], "to_port", null)
  icmp_code       = lookup(var.qa_inbound_acl_rules[count.index], "icmp_code", null)
  icmp_type       = lookup(var.qa_inbound_acl_rules[count.index], "icmp_type", null)
  protocol        = var.qa_inbound_acl_rules[count.index]["protocol"]
  cidr_block      = lookup(var.qa_inbound_acl_rules[count.index], "cidr_block", null)
  ipv6_cidr_block = lookup(var.qa_inbound_acl_rules[count.index], "ipv6_cidr_block", null)
}

resource "aws_network_acl_rule" "qa_outbound" {
  count = length(var.qa_subnets) > 0 ? length(var.qa_outbound_acl_rules) : 0

  network_acl_id = aws_network_acl.aclqc[0].id

  egress          = true
  rule_number     = var.qa_outbound_acl_rules[count.index]["rule_number"]
  rule_action     = var.qa_outbound_acl_rules[count.index]["rule_action"]
  from_port       = lookup(var.qa_outbound_acl_rules[count.index], "from_port", null)
  to_port         = lookup(var.qa_outbound_acl_rules[count.index], "to_port", null)
  icmp_code       = lookup(var.qa_outbound_acl_rules[count.index], "icmp_code", null)
  icmp_type       = lookup(var.qa_outbound_acl_rules[count.index], "icmp_type", null)
  protocol        = var.qa_outbound_acl_rules[count.index]["protocol"]
  cidr_block      = lookup(var.qa_outbound_acl_rules[count.index], "cidr_block", null)
  ipv6_cidr_block = lookup(var.qa_outbound_acl_rules[count.index], "ipv6_cidr_block", null)
}

// DEV ACL
resource "aws_network_acl" "acldev" {
  count = length(var.dev_subnets) > 0 ? 1 : 0

  vpc_id     = aws_vpc.vpc.id
  subnet_ids = aws_subnet.dev_subnet.*.id

  tags = merge(
    {
      "Name" = format("%s-${var.dev_subnet_suffix}", var.envrname)
    },
    var.tags,
    var.dev_acl_tags,
  )
}
resource "aws_network_acl_rule" "dev_inbound" {
  count = length(var.dev_subnets) > 0 ? length(var.dev_inbound_acl_rules) : 0

  network_acl_id = aws_network_acl.acldev[0].id

  egress          = false
  rule_number     = var.dev_inbound_acl_rules[count.index]["rule_number"]
  rule_action     = var.dev_inbound_acl_rules[count.index]["rule_action"]
  from_port       = lookup(var.dev_inbound_acl_rules[count.index], "from_port", null)
  to_port         = lookup(var.dev_inbound_acl_rules[count.index], "to_port", null)
  icmp_code       = lookup(var.dev_inbound_acl_rules[count.index], "icmp_code", null)
  icmp_type       = lookup(var.dev_inbound_acl_rules[count.index], "icmp_type", null)
  protocol        = var.dev_inbound_acl_rules[count.index]["protocol"]
  cidr_block      = lookup(var.dev_inbound_acl_rules[count.index], "cidr_block", null)
  ipv6_cidr_block = lookup(var.dev_inbound_acl_rules[count.index], "ipv6_cidr_block", null)
}

resource "aws_network_acl_rule" "dev_outbound" {
  count = length(var.dev_subnets) > 0 ? length(var.dev_outbound_acl_rules) : 0

  network_acl_id = aws_network_acl.acldev[0].id

  egress          = true
  rule_number     = var.dev_outbound_acl_rules[count.index]["rule_number"]
  rule_action     = var.dev_outbound_acl_rules[count.index]["rule_action"]
  from_port       = lookup(var.dev_outbound_acl_rules[count.index], "from_port", null)
  to_port         = lookup(var.dev_outbound_acl_rules[count.index], "to_port", null)
  icmp_code       = lookup(var.dev_outbound_acl_rules[count.index], "icmp_code", null)
  icmp_type       = lookup(var.dev_outbound_acl_rules[count.index], "icmp_type", null)
  protocol        = var.dev_outbound_acl_rules[count.index]["protocol"]
  cidr_block      = lookup(var.dev_outbound_acl_rules[count.index], "cidr_block", null)
  ipv6_cidr_block = lookup(var.dev_outbound_acl_rules[count.index], "ipv6_cidr_block", null)
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
  count  = length(var.app_subnets)

  route {
    cidr_block                = var.rtsharedservice
    vpc_peering_connection_id = aws_vpc_peering_connection.default.id
  }

  tags = merge(
    {
      "Name"        = format("%s-${var.app_subnet_suffix}-%s", var.envrname, element(var.azs, count.index), )
      "Description" = format("%s-${var.app_subnet_suffix}-%s", var.envrname, element(var.azs, count.index), )
    },
    var.tags,
    var.app_route_table_tags,
  )
}

# PROD Route
resource "aws_route_table" "rtprod" {
  vpc_id = aws_vpc.vpc.id
  count  = length(var.prod_subnets)

  tags = merge(
    {
      "Name"        = format("%s-${var.prod_subnet_suffix}-%s", var.envrname, element(var.azs, count.index), )
      "Description" = format("%s-${var.prod_subnet_suffix}-%s", var.envrname, element(var.azs, count.index), )
    },
    var.tags,
    var.prod_route_table_tags,
  )
}

# QA Route
resource "aws_route_table" "rtqa" {
  vpc_id = aws_vpc.vpc.id
  count  = length(var.qa_subnets)

  tags = merge(
    {
      "Name"        = format("%s-${var.qa_subnet_suffix}-%s", var.envrname, element(var.azs, count.index), )
      "Description" = format("%s-${var.qa_subnet_suffix}-%s", var.envrname, element(var.azs, count.index), )
    },
    var.tags,
    var.qa_route_table_tags,
  )
}

# DEV Route
resource "aws_route_table" "rtdev" {
  vpc_id = aws_vpc.vpc.id
  count  = length(var.dev_subnets)

  tags = merge(
    {
      "Name"        = format("%s-${var.dev_subnet_suffix}-%s", var.envrname, element(var.azs, count.index), )
      "Description" = format("%s-${var.dev_subnet_suffix}-%s", var.envrname, element(var.azs, count.index), )
    },
    var.tags,
    var.dev_route_table_tags,
  )
}

### Associate Route Table with Subnet
resource "aws_route_table_association" "app" {
  count          = length(var.app_subnets)
  subnet_id      = aws_subnet.app_subnet[count.index].id
  route_table_id = aws_route_table.rtapp[count.index].id
}

resource "aws_route_table_association" "prod" {
  count          = length(var.prod_subnets)
  subnet_id      = aws_subnet.prod_subnet[count.index].id
  route_table_id = aws_route_table.rtprod[count.index].id
}

resource "aws_route_table_association" "qa" {
  count          = length(var.qa_subnets)
  subnet_id      = aws_subnet.qa_subnet[count.index].id
  route_table_id = aws_route_table.rtqa[count.index].id
}


resource "aws_route_table_association" "dev" {
  count          = length(var.dev_subnets)
  subnet_id      = aws_subnet.dev_subnet[count.index].id
  route_table_id = aws_route_table.rtdev[count.index].id
}