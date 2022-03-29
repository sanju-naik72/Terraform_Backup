
module "my-vpc" {
    source = "../main/vpc"
    vpc_cidr = "10.0.0.0/16"
    v_vpc_id = module.my-vpc.v_vpc_id
    v_sn1 = module.my-vpc.v_sn1
    v_sn2 = module.my-vpc.v_sn2
    az = module.my-vpc.az
}