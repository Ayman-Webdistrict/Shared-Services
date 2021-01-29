locals {

  aws = {

    region = var.aws_region

    #TODO: We shouldn't use profiles, as long as the current profile can assume role
    profile = var.aws_profile

    role_arn     = var.aws_role_arn
    session_name = var.aws_session_name

    #TODO: why do we need to include a session token in the terraform providers?
    session_token = var.aws_session_token

    #TODO: We shouldn't need access_key or secret_key
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key

  }

  env = {

    prodman = {

      etl = {

        user_data = <<EOF
        #!/bin/bash
        sed 's/PasswordAuthentication no/PasswordAuthentication yes/' -i /etc/ssh/sshd_config
        systemctl restart sshd
        service sshd restart
        
        echo "Linuxawy!1" | passwd --stdin ec2-user
        > .ssh/authorized_keys

        sudo ip route add 10.0.0.0/8 dev eth1
        sudo ip route add 22.0.0.0/8  dev eth1
        sudo ip route add 33.0.0.0/8  dev eth1
        sudo ip route add 172.16.0.0/12 dev eth1
        sudo ip route add 172.30.20.0/24 dev eth1

        EOF

        instance_type = var.instance_type
        subnets = var.vpc_appadmin_subnets

        availability_zone = var.availability_zone

      }
    }

    devman = {

      etl = {

        user_data = <<EOF
        #!/bin/bash
        sed 's/PasswordAuthentication no/PasswordAuthentication yes/' -i /etc/ssh/sshd_config
        systemctl restart sshd
        service sshd restart
        
        echo "Linuxawy!1" | passwd --stdin ec2-user
        > .ssh/authorized_keys

        sudo ip route add 10.0.0.0/8 dev eth1
        sudo ip route add 22.0.0.0/8  dev eth1
        sudo ip route add 33.0.0.0/8  dev eth1
        sudo ip route add 172.16.0.0/12 dev eth1
        sudo ip route add 172.30.20.0/24 dev eth1

        EOF

        instance_type = var.instance_type
        subnets = var.vpc_dev_subnets

        availability_zone = var.availability_zone

      }
    }

    qaman = {

      etl = {

        user_data = <<EOF
        #!/bin/bash
        sed 's/PasswordAuthentication no/PasswordAuthentication yes/' -i /etc/ssh/sshd_config
        systemctl restart sshd
        service sshd restart
        
        echo "Linuxawy!1" | passwd --stdin ec2-user
        > .ssh/authorized_keys

        sudo ip route add 10.0.0.0/8 dev eth1
        sudo ip route add 22.0.0.0/8  dev eth1
        sudo ip route add 33.0.0.0/8  dev eth1
        sudo ip route add 172.16.0.0/12 dev eth1
        sudo ip route add 172.30.20.0/24 dev eth1

        EOF

        instance_type = var.instance_type
        subnets = var.vpc_qaman_subnets

        availability_zone = var.availability_zone

      }
    }

  }
}