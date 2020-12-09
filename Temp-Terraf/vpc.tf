
resource "aws_vpc" "SpringCS" {
    cidr_block           = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support   = true
    instance_tenancy     = "default"

    tags {
        "Name" = "SpringCS"
    }
}

resource "aws_subnet" "subnet-08e8c73ba0f6792e1-PublicSubNet-AZ2" {
    vpc_id                  = "vpc-0596c743b7ae6b87f"
    cidr_block              = "10.0.100.0/24"
    availability_zone       = "ca-central-1b"
    map_public_ip_on_launch = false

    tags {
        "Name" = "PublicSubNet-AZ2"
    }
}


resource "aws_subnet" "subnet-08aac5ab474d0e71d-DataSubNet-AZ2" {
    vpc_id                  = "vpc-0596c743b7ae6b87f"
    cidr_block              = "10.0.20.0/24"
    availability_zone       = "ca-central-1b"
    map_public_ip_on_launch = false

    tags {
        "Name" = "DataSubNet-AZ2"
    }
}

resource "aws_subnet" "subnet-04795d6696c008bde-ProcessSubNet-AZ2" {
    vpc_id                  = "vpc-0596c743b7ae6b87f"
    cidr_block              = "10.0.10.0/24"
    availability_zone       = "ca-central-1b"
    map_public_ip_on_launch = false

    tags {
        "Name" = "ProcessSubNet-AZ2"
    }
}

resource "aws_subnet" "subnet-01b311eb8d64a03cb-PublicSubNet-AZ1" {
    vpc_id                  = "vpc-0596c743b7ae6b87f"
    cidr_block              = "10.0.0.0/24"
    availability_zone       = "ca-central-1a"
    map_public_ip_on_launch = false

    tags {
        "Name" = "PublicSubNet-AZ1"
    }
}

resource "aws_subnet" "subnet-0d2db9fc39893e945-ProcessSubNet-AZ1" {
    vpc_id                  = "vpc-0596c743b7ae6b87f"
    cidr_block              = "10.0.1.0/24"
    availability_zone       = "ca-central-1a"
    map_public_ip_on_launch = false

    tags {
        "Name" = "ProcessSubNet-AZ1"
    }
}

resource "aws_subnet" "subnet-0135fe944b32e6501-DataSubNet-AZ1" {
    vpc_id                  = "vpc-0596c743b7ae6b87f"
    cidr_block              = "10.0.2.0/24"
    availability_zone       = "ca-central-1a"
    map_public_ip_on_launch = false

    tags {
        "Name" = "DataSubNet-AZ1"
    }
}


resource "aws_security_group" "vpc-0596c743b7ae6b87f-PublicSecgroup" {
    name        = "PublicSecgroup"
    description = "Grupo de seguridad para la red de internet"
    vpc_id      = "vpc-0596c743b7ae6b87f"

    ingress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
        ipv6_cidr_blocks     = ["::/0"]
    }


    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    tags {
        "Name" = "Public-SecGroup"
    }
}

resource "aws_security_group" "vpc-0596c743b7ae6b87f-DataDB-SecGroup" {
    name        = "DataDB-SecGroup"
    description = "Carga de datos"
    vpc_id      = "vpc-0596c743b7ae6b87f"

    ingress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["10.0.20.0/24", "10.0.2.0/24"]
    }

    ingress {
        from_port       = 3306
        to_port         = 3306
        protocol        = "tcp"
        security_groups = ["sg-0d416d7c662725fe8"]
        self            = false
    }


    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    tags {
        "Name" = "DataDB-SecGroup"
    }
}

resource "aws_security_group" "vpc-0596c743b7ae6b87f-default" {
    name        = "default"
    description = "default VPC security group"
    vpc_id      = "vpc-0596c743b7ae6b87f"

    ingress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        security_groups = []
        self            = true
    }


    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

}

resource "aws_security_group" "vpc-0596c743b7ae6b87f-Process-SegGroup" {
    name        = "Process-SegGroup"
    description = "Grupo de seguridad para capa media"
    vpc_id      = "vpc-0596c743b7ae6b87f"

    ingress {
        from_port       = 80
        to_port         = 80
        protocol        = "tcp"
        security_groups = ["sg-04d7e11d4173ff63d"]
        self            = false
    }

    ingress {
        from_port       = 8080
        to_port         = 8080
        protocol        = "tcp"
        security_groups = ["sg-04d7e11d4173ff63d"]
        self            = false
    }

    ingress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["10.0.1.0/24", "10.0.10.0/24"]
    }

    ingress {
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks     = ["186.154.3.96/32"]
    }

    ingress {
        from_port       = 8443
        to_port         = 8443
        protocol        = "tcp"
        security_groups = ["sg-04d7e11d4173ff63d"]
        self            = false
    }

    ingress {
        from_port       = 3306
        to_port         = 3306
        protocol        = "tcp"
        security_groups = ["sg-05753e6e5e6f8de89"]
        self            = false
    }

    ingress {
        from_port       = 443
        to_port         = 443
        protocol        = "tcp"
        security_groups = ["sg-04d7e11d4173ff63d"]
        self            = false
    }


    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    tags {
        "Name" = "Process-SecGroup"
    }
}

resource "aws_security_group" "vpc-0596c743b7ae6b87f-Spring-1091" {
    name        = "Spring-1091"
    description = "2020-12-03T01:38:33.496Z"
    vpc_id      = "vpc-0596c743b7ae6b87f"

    ingress {
        from_port       = 80
        to_port         = 80
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
    }


    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

}


resource "aws_eip" "eipalloc-08a60cd23d049121a" {
    network_interface = "eni-0974899852da53509"
    vpc               = true
}

resource "aws_eip" "eipalloc-0938ff47ce344a013" {
    network_interface = "eni-075d353eff8cdbb90"
    vpc               = true
}

resource "aws_internet_gateway" "Internet" {
    vpc_id = "vpc-0596c743b7ae6b87f"

    tags {
        "Name" = "Internet"
    }
}


resource "aws_nat_gateway" "nat-036e33f64fdb2141c" {
    allocation_id = "eipalloc-08a60cd23d049121a"
    subnet_id = "subnet-01b311eb8d64a03cb"
}

resource "aws_nat_gateway" "nat-037eabbec199ae851" {
    allocation_id = "eipalloc-0938ff47ce344a013"
    subnet_id = "subnet-01b311eb8d64a03cb"
}

resource "aws_route_table" "PublicRouteTable" {
    vpc_id     = "vpc-0596c743b7ae6b87f"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "igw-0c70de6e89b3ddf6b"
    }

    tags {
        "Name" = "PublicRouteTable"
    }
}

resource "aws_route_table" "rtb-0f69dec0be705bfb2" {
    vpc_id     = "vpc-0596c743b7ae6b87f"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "igw-0c70de6e89b3ddf6b"
    }

    tags {
    }
}

resource "aws_route_table" "rtb-0371b6681ec992657" {
    vpc_id     = "vpc-0596c743b7ae6b87f"

    route {
        cidr_block = "0.0.0.0/0"
    }

    tags {
    }
}

resource "aws_route_table" "ProcessRouteTable" {
    vpc_id     = "vpc-0596c743b7ae6b87f"

    route {
        cidr_block = "0.0.0.0/0"
    }

    tags {
        "Name" = "ProcessRouteTable"
    }
}



resource "aws_alb" "SpringCS-ALB" {
    idle_timeout    = 60
    internal        = false
    name            = "SpringCS-ALB"
    security_groups = ["sg-04d7e11d4173ff63d"]
    subnets         = ["subnet-01b311eb8d64a03cb", "subnet-08e8c73ba0f6792e1"]

    enable_deletion_protection = false

    tags {
        "Name" = "SpringCS-ALB"
    }
}

resource "aws_alb" "Prb1" {
    idle_timeout    = 60
    internal        = false
    name            = "Prb1"
    security_groups = ["sg-04d7e11d4173ff63d"]
    subnets         = ["subnet-01b311eb8d64a03cb", "subnet-08e8c73ba0f6792e1"]

    enable_deletion_protection = false

    tags {
    }
}

