resource "aws_iam_role" "dr-cloudwatch-role" {
  name = "CloudWatch-EC2-VPCFlowLogs-Role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "dr-cloudwatch-policy" {
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "cloudwatch:PutMetricData",
          "cloudwatch:PutDashboard",
          "cloudwatch:PutMetricAlarm",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams",
          "logs:PutRetentionPolicy"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_cloudwatch_policy" {
  policy_arn = aws_iam_policy.dr-cloudwatch-policy.arn
  role       = aws_iam_role.dr-cloudwatch-role.name
}


resource "aws_iam_role" "dr-s3-replication-role" {
  name = "DR-S3-Replication-Role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "s3.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "dr-s3-replication-policy" {
  name = "DR-S3-Replication-Policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "s3:GetReplicationConfiguration",
        "s3:ListBucket"
      ]
      Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:GetObjectVersion",
          "s3:GetObjectVersionAcl",
          "s3:ReplicateObject",
          "s3:ReplicateDelete"
        ]
        Resource = "*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "attach_s3_replication_policy" {
  policy_arn = aws_iam_policy.dr-s3-replication-policy.arn
  role       = aws_iam_role.dr-s3-replication-role.name
}


resource "aws_iam_role" "dr-backup-role" {
  name = "DR-Backup-Role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "backup.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "dr-backup-policy" {
  name = "DR-Backup-Policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "backup:GetBackupPlan",
        "backup:GetBackupVault",
        "backup:GetBackupVaultAccessPolicy",
        "backup:GetBackupVaultNotifications",
        "backup:GetBackupVaultLockConfiguration",
        "backup:StartCopyJob",
        "backup:StartExportJob",
        "tag:GetResources"
      ]
      Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "ec2:DescribeInstances",
          "rds:DescribeDBInstances",
          "efs:DescribeFileSystems",
          "backup:StartBackupJob"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:DeleteObject"
        ]
        Resource = [
          var.dr-s3-bucket-arn,
          "${var.dr-s3-bucket-arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_backup_policy" {
  policy_arn = aws_iam_policy.dr-backup-policy.arn
  role       = aws_iam_role.dr-backup-role.name
}

resource "aws_iam_role" "dr-sns-role" {
  name = "DR-SNS-Role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "sns.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "dr-sns-policy" {
  name = "DR-SNS-Policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "sns:Publish"
      ]
      Resource = [var.sns_topic_arn]
    }]
  })
}

resource "aws_iam_role_policy_attachment" "attach_sns_policy" {
  policy_arn = aws_iam_policy.dr-sns-policy.arn
  role       = aws_iam_role.dr-sns-role.name
}

# resource "aws_sns_topic_policy" "dr-sns-default-policy" {
#   arn = var.sns_topic_arn
#   policy = data.aws_iam_policy_document.sns_topic_policy.json
# }

# data "aws_iam_policy_document" "sns_topic_policy" {
#   statement {
#     effect = "Allow"
#     actions = ["sns:Publish"]
#     principals {
#       type = "AWS"
#       identifiers = [aws_iam_role.dr-sns-role.arn]
#     }
#     resources = [var.sns_topic_arn]
#   }
# }
