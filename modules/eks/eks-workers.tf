resource "aws_iam_role" "eks_nodes" {
  name = var.node_group_iam_role_name

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_nodes.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_nodes.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_nodes.name
}

resource "aws_launch_template" "eks_node_template" {
  name = "eks-node-template"

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      encrypted = true
      kms_key_id = aws_kms_key.encryption_key.arn
      volume_size = 20
      volume_type = "gp3"
    }
  }
}
resource "aws_eks_node_group" "default_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = var.default_node_group_name
  node_role_arn   = aws_iam_role.eks_nodes.arn    
  subnet_ids      = var.subnet_ids_for_eks_cluster_node_group
  instance_types  =   var.default_node_group_instance_type
 # disk_size = var.default_node_disk_size
  launch_template {
    id = aws_launch_template.eks_node_template.id
    version = "1"
  }
  tags =  {
    "Environment" = var.environment_name
    "Name" = var.default_node_group_name
  }
  scaling_config {
    desired_size = var.eks_desired_size_default_node
    max_size     = var.eks_max_size_default_node
    min_size     = var.eks_min_size_default_node
  }
  lifecycle {
    create_before_destroy ="true"
  }
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}

resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  count           = length(var.node_group_name)
  node_group_name = var.node_group_name[count.index]
  node_role_arn   = aws_iam_role.eks_nodes.arn    
  subnet_ids      = var.subnet_ids_for_eks_cluster_node_group
  instance_types  =   [var.eks_instance_type[count.index]]
  #disk_size = var.node_disk_size[count.index]
  launch_template {
    id = aws_launch_template.eks_node_template.id
    version = "1"
  }
  /*taint {
    key = "service"
    value  = var.eks_cluster_node_group_taint_value[count.index]
    effect = "NO_SCHEDULE"
  }*/

  tags =  {
    "Environment" = var.environment_name
    "Name"  = var.node_group_name[count.index]
  }
  /*labels = {
    service = var.eks_cluster_node_group_taint_value[count.index]
  }*/
  scaling_config {
    
    desired_size = var.eks_desired_size[count.index]
    max_size     = var.eks_max_size[count.index]
    min_size     = var.eks_min_size[count.index]
  }
  lifecycle {
    create_before_destroy ="true"
  }
  
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}
