# File generated by aws2tf see https://github.com/aws-samples/aws2tf

resource "aws_iam_role" "eks-cluster-ServiceRole-HUIGIC7K7HNJ" {
  assume_role_policy = jsonencode(
    {
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Principal = {
            Service = [
              "eks-fargate-pods.amazonaws.com",
              "eks.amazonaws.com",
            ]
          }
        },
      ]
      Version = "2012-10-17"
    }
  )
  force_detach_policies = false
  max_session_duration  = 3600
  name                  = "eks-cluster-ServiceRole-${var.env_name}-${var.cluster_name}"
  path                  = "/"
  tags = {
    "Name"  = "eks-cluster-ServiceRole-${var.env_name}-${var.cluster_name}"

  }
}

# File generated by aws2tf see https://github.com/aws-samples/aws2tf
resource "aws_iam_role_policy" "eks-cluster-ServiceRole-HUIGIC7K7HNJ__eks-cluster-PolicyCloudWatchMetrics" {
  name = "eks-cluster-PolicyCloudWatchMetrics"
  policy = jsonencode(
    {
      Statement = [
        {
          Action = [
            "cloudwatch:PutMetricData",
          ]
          Effect   = "Allow"
          Resource = "*"
        },
      ]
      Version = "2012-10-17"
    }
  )
  role = aws_iam_role.eks-cluster-ServiceRole-HUIGIC7K7HNJ.id
}
# File generated by aws2tf see https://github.com/aws-samples/aws2tf
resource "aws_iam_role_policy_attachment" "eks-cluster-ServiceRole-HUIGIC7K7HNJ__AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-cluster-ServiceRole-HUIGIC7K7HNJ.id
}

# File generated by aws2tf see https://github.com/aws-samples/aws2tf
resource "aws_iam_role_policy_attachment" "eks-nodegroup-ng-ma-NodeInstanceRole-1GFKA1037E1XO__AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks-nodegroup-ng-ma-NodeInstanceRole-1GFKA1037E1XO.id
}


output "cluster_service_role_arn" {
  value = aws_iam_role.eks-cluster-ServiceRole-HUIGIC7K7HNJ.arn
}