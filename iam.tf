provider "aws" {
  region = "ap-south-1"  # Replace with your desired AWS region
}

# Create IAM User
resource "aws_iam_user" "ec2_user" {
  name = "ec2-user"
}

# Create an IAM Policy that grants permissions to manage EC2 instances
resource "aws_iam_policy" "ec2_permissions" {
  name        = "EC2Permissions"
  description = "Policy to allow EC2 instance management"

  # This policy allows user to create, describe, start, stop EC2 instances
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:DescribeInstances",
          "ec2:RunInstances",
          "ec2:StartInstances",
          "ec2:StopInstances",
          "ec2:TerminateInstances",
          "ec2:RebootInstances"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

# Attach the policy to the IAM user
resource "aws_iam_user_policy_attachment" "user_ec2_policy" {
  user       = aws_iam_user.ec2_user.name
  policy_arn = aws_iam_policy.ec2_permissions.arn
}

# Create a login profile (without setting the password attribute)
resource "aws_iam_user_login_profile" "ec2_user_login" {
  user                   = aws_iam_user.ec2_user.name
  password_reset_required = true
}
