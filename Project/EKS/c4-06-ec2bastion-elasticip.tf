# Create Elastic IP for Bastion Host
# Resource - depends_on Meta-Argument
resource "aws_eip" "bastion_eip" {
  depends_on = [module.ec2_public, module.vpc ]
  instance = module.ec2_public.id
  domain   = "vpc"
  tags = local.common_tags  
}
resource "aws_eip_association" "bastion_eip_assoc" {
  instance_id   = module.ec2_public.id
  allocation_id = aws_eip.bastion_eip.id
}