module "vpc" {
  source = "./vpc"
  vpc_id = module.vpc.vpc_id
}
module "security_group" {
  source = "./security_groups"
  vpc_id = module.vpc.vpc_id
}
module "ec2" {
    source = "./ec2"
    vpc_id = module.vpc.vpc_id
    security_group_id = module.security_group.security_group_id
    public_subnet_id = module.vpc.public_subnet_id
    private_subnet_id = module.vpc.private_subnet_id
} 