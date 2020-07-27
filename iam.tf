data "aws_iam_policy_document" "dns_challenge_read_write_access" {
  statement {
    actions = [
      "route53:ListHostedZonesByName"
    ]

    resources = [
      "*"
    ]

    effect = "Allow"
  }

  statement {
    actions = [
      "route53:ChangeResourceRecordSets"
    ]

    resources = [
      "arn:aws:route53:::hostedzone/${aws_route53_zone.this.id}",
      "arn:aws:route53:::hostedzone/${data.aws_route53_zone.base.id}"
    ]

    effect = "Allow"
  }

  statement {
    actions = [
      "route53:GetChange"
    ]

    resources = [
      "arn:aws:route53:::change/*"
    ]

    effect = "Allow"
  }
}

resource "aws_iam_user_policy" "cert_manager_dns_challenge_read_write_access" {
  name   = "dns-challenge-read-write-access"
  user   = var.service_accounts.cert_manager.name
  policy = data.aws_iam_policy_document.dns_challenge_read_write_access.json
}
