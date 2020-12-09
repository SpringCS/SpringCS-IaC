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

