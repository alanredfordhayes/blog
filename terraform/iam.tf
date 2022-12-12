resource "aws_iam_role" "roles" {
    name = "${local.project_name}_Role"
    assume_role_policy = local.aws_iam_role__roles__asume_role_policy
}

resource "aws_iam_role_policy_attachment" "role_attachments" {
    role       = aws_iam_role.roles.name
    policy_arn = local.aws_iam_role_policy_attachment__policy_attachments__policy_arn
}

resource "aws_iam_policy" "polices" {
    name = "${local.project_name}_Policy"
    description = local.aws_iam_policy__policies__name
    policy = local.aws_iam_policy__policies__policy
}

resource "aws_iam_role_policy_attachment" "policy_attachments" {
    role       = aws_iam_role.roles.name
    policy_arn = aws_iam_policy.polices.arn
}