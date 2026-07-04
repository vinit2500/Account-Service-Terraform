resource "aws_vpc" "this" {

  # cidr kya hai Meri VPC ke andar kitne IP addresses available honge.
  cidr_block = var.vpc_cidr

  enable_dns_support   = true
  enable_dns_hostnames = true

}

#VPC = Ek bada private area jo sirf tumhara hai.
#Subnet = VPC ka ek chhota part.

#public subnet = yha internet direct aa sakta hai (alb)
#private subnet = yha internet direct nhi aa sakta hai (spring boot application)

#VPC ek bada private network hai aur subnet us network ka chhota hissa (partition) hai.

# AWS

# ┌──────────────────────────────┐
# │            VPC               │
# │                              │
# │  ┌──────────┐ ┌──────────┐   │
# │  │ Public   │ │ Private  │   │
# │  │ Subnet   │ │ Subnet   │   │
# │  └──────────┘ └──────────┘   │
# │                              │
# └──────────────────────────────┘

#Public subnet ka matlab ye nahi ki wo VPC ke bahar hai.
#Wo VPC ke andar hi hota hai.
# Difference sirf itna hai:

# VPC
# │
# ├── Public Subnet
# │      ✔ Internet se direct traffic aa sakta hai.
# │
# └── Private Subnet
#        ❌ Internet se direct traffic nahi aa sakta.


#Lekin internet sirf Public Subnet tak hi kyu pahunchta hai?
#ye subnet khud decide nahi karta. ye decide karta hai route table  Aur Route Table me ek rule hota hai.
#Example 
# Destination        Target

# 0.0.0.0/0          Internet Gateway
# Iska matlab "Agar internet ki traffic aaye, to Internet Gateway ke through bhejo."
# Jis subnet ki Route Table me ye rule hota hai... Wo Public Subnet ban jata hai. Jis subnet me ye rule nahi hota... 👉 Wo Private Subnet hota hai.
#Yaani "public" ya "private" hona subnet ki property nahi hai, uski routing ki wajah se hota hai.
#Har subnet ki apni alag Route Table ho sakti hai.


#Agar ECS(spring boot application) Private Subnet me hai aur uski Route Table me Internet Gateway ka route nahi hai,
# to wo internet par request(3rd party like razorpay) kaise bhejegi?

# Hint: Iske liye AWS me ek bahut important service hoti hai jiska naam NAT Gateway hai. Ye hum agla concept seekhenge.

#NAT gateway = Private subnet ke resources internet par request bhej sakte hain, lekin internet unhe directly access nahi kar sakta.

#Daigram 

# Internet
#      ▲
#      │
# ┌─────────────┐
# │ NAT Gateway │
# └─────────────┘
#       ▲
#       │
# Private Subnet
#       ▲
#       │
#      ECS


#                       Internet
#                            │
#                            ▼
#                    Internet Gateway
#                            │
#                            ▼
#                   Public Subnet
#                            │
#                     ALB + NAT Gateway
#                            │
# -----------------------------------------------------
#                            │
#                   Private Subnet
#                            │
#                           ECS
#                            │
#                            ▼
#                           RDS

# Dhyan do:

# ALB internet se request leta hai.
# NAT Gateway private subnet ko internet access deta hai.
# ECS private subnet me rehta hai.
# RDS bhi private subnet me rehti hai.



#Internet Gateway = Public subnet ke resources ko internet se connect karta hai.
# NAT Gateway = Private subnet ke resources ko internet access deta hai.

#security group AWS ka firewall