
# create group admin
resource "aws_iam_group" "admin" {
  name = "admin"
}

# attach administrative access policy to the group
resource "aws_iam_group_policy_attachment" "administrative-attach" {
  group      = aws_iam_group.admin.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

output "group_id" {
    value = aws_iam_group.admin.id
}

output "group_arn" {
    value = aws_iam_group.admin.arn
}

output "group_name" {
    value = aws_iam_group.admin.name
}
