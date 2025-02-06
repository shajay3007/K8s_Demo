output "cluster_id" {
  value = aws_eks_cluster.cicd-eks.id
}

output "node_group_id" {
  value = aws_eks_node_group.cicd-nodegroup.id
}

output "vpc_id" {
  value = aws_vpc.cicd_vpc.id
}

output "subnet_ids" {
  value = aws_subnet.cicd_subnet[*].id
}

