# data "aws_iam_policy_document" "assume_role_codedeploy" {
#   statement {
#     effect = "Allow"

#     principals {
#       type        = "Service"
#       identifiers = ["codedeploy.amazonaws.com"]
#     }

#     actions = ["sts:AssumeRole"]
#   }
# }

# resource "aws_iam_role" "code_deploy_role" {
#   name               = "Code-Deploy-Role"
#   assume_role_policy = data.aws_iam_policy_document.assume_role_codedeploy.json
# }


# resource "aws_iam_role_policy_attachment" "codedeploy_s3_policy_attachment" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
#   role       = aws_iam_role.code_deploy_role.name
# }

# resource "aws_iam_role_policy_attachment" "aws_codedeploy_policy_attachment" {
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
#   role       = aws_iam_role.code_deploy_role.name
# }

# data "aws_iam_policy_document" "assume_role_ec2" {
#   statement {
#     effect = "Allow"

#     principals {
#       type        = "Service"
#       identifiers = ["ec2.amazonaws.com"]
#     }

#     actions = ["sts:AssumeRole"]
#   }
# }

# resource "aws_iam_role" "ec2_role" {
#   name               = "CodeDeployRoleForEC2"
#   assume_role_policy = data.aws_iam_policy_document.assume_role_ec2.json
# }

# resource "aws_iam_role_policy_attachment" "ec2_codedeploy_policy_attachment" {
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforAWSCodeDeploy"
#   role       = aws_iam_role.ec2_role.name
# }

# resource "aws_iam_role_policy_attachment" "ec2_s3_policy_attachment" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
#   role       = aws_iam_role.ec2_role.name
# }

# resource "aws_iam_role_policy_attachment" "ec2_imagebuilder_policy_attachment" {
#   policy_arn = "arn:aws:iam::aws:policy/service-role/EC2InstanceProfileForImageBuilderECRContainerBuilds"
#   role       = aws_iam_role.ec2_role.name
# }

# resource "aws_iam_instance_profile" "ec2_profile" {
#   name = "CodeDeployProfileForEC2"
#   role = aws_iam_role.ec2_role.name
# }

data "aws_iam_policy_document" "app_runner_assume_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["build.apprunner.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "app_runner_role" {
  name               = "app-runner-ecr-role"
  assume_role_policy = data.aws_iam_policy_document.app_runner_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "app_runner_ecr_read_only" {
  role = aws_iam_role.app_runner_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "app_runner_service_policy" {
  role       = aws_iam_role.app_runner_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSAppRunnerServicePolicyForECRAccess"
}