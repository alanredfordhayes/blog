resource "aws_iam_role" "roles" {
    for_each = aws_s3_object.objects
    name = "${local.project_name}__Role__${each.value.tags.key}"
    assume_role_policy = local.aws_iam_role__roles__asume_role_policy
    tags = {
        site = each.value.tags.key
    }
}

resource "aws_iam_role_policy_attachment" "role_attachments" {
    for_each   = aws_iam_role.roles
    role       = each.value.name
    policy_arn = local.aws_iam_role_policy_attachment__policy_attachments__policy_arn
}

resource "aws_iam_policy" "policy" {
    for_each   = aws_iam_role.roles
    name = "${local.project_name}_Policy_${each.value.tags.site}"
    path = local.aws_iam_policy_path
    policy = local.aws_iam_policy__policies__policy
    tags = {
        site = each.value.tags.site
    }
}

resource "aws_iam_policy_attachment" "policy_attachments" {
    for_each = aws_iam_policy.policy
    name = "${local.project_name}_Policy_${each.value.tags.site}"
    roles = [aws_iam_role.roles.name]
    policy_arn = aws_iam_policy.policy[each.key].arn
}