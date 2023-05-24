# AWS EKS cluster using Terraform

terraform commands:
- init `terraform init`
- on changes run `terraform plan`
- then deploy `terraform apply -auto-approve`
- to remove infrastructure run `terraform destroy`

connect to cluster:
- `aws eks update-kubeconfig --name <cluster_name> --region <region>`

check nodes:
- `kubectl get nodes`