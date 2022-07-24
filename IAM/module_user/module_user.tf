

variable "grp_name" {
  
}

resource "aws_iam_user" "rpharate" {
  name = "rpharate"
}


resource "aws_iam_group_membership" "team" {
  name = "tf-testing-group-membership"

  users = [
    aws_iam_user.rpharate.name
  ]

  group = "${var.grp_name}"
  
}