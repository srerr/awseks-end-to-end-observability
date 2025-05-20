
resource "aws_db_subnet_group" "multi-az" {
    #vpc_id     = aws_vpc.vpc-demo.id
    name       = "mydb-subnet-group"
    subnet_ids = [aws_subnet.private-subnet1.id, aws_subnet.private-subnet2.id]
    tags = {
        Name = "mydb-subnet-group"
    }
}

resource "aws_security_group" "rds_sg" {
    vpc_id = aws_vpc.vpc-demo.id

    ingress {
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "rds_sg"
    }
}
resource "aws_db_parameter_group" "mysql" {
    name   = "mysql-parameter-group"
    family = "mysql8.0"

    parameter {
        name  = "init_connect"
        value = "CREATE DATABASE IF NOT EXISTS job"
    }

    tags = {
        Name = "mysql-parameter-group"
    }
}
resource "aws_db_instance" "mysql" {
    db_subnet_group_name = aws_db_subnet_group.multi-az.id
    vpc_security_group_ids = [aws_security_group.rds_sg.id]
    identifier           = "job"
    allocated_storage    = 20
    storage_type         = "gp2"
    engine               = "mysql"
    engine_version       = "8.0.40"
    instance_class       = "db.t3.medium"
    #db_name              = "mydb-django"
    username             = "admin"
    password             = "Sreeeram#521"
    parameter_group_name = aws_db_parameter_group.mysql.name
    skip_final_snapshot  = true
    publicly_accessible  = false
    port = "3306"
    tags = {
        Name = "mydb-django"
    }
}