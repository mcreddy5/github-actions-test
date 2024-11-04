# Terraform Script - Revlitix Infrastructure
Contains Revlitix infrastructure as a code.
## modules
- VPC - 14 Resources
- EKS - 13 Resoureces
- EC2 - 58 Resources
    - 1 data
    - 7  ebs
    - 7 volume attachment
    - 13 instances
    - 10 sg
    - 20 sg-rules
Total 84 resources as we exclude 1 data resource, data is just to read, others are create.

Modules can be provisioned individually too.
