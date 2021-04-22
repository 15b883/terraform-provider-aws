



```
# 初始化工作目录
terraform init
terraform init -input=false

# 创建执行计划
terraform plan
# 创建一个计划并将其保存到本地文件中tfplan
terraform plan -out=tfplan -input=false

# 检查当前状态
terraform show

# 应用执行计划
terraform apply
# 应用存储在文件中的计划tfplan
terraform apply -input=false tfplan
# 应用计划自动批准
terraform apply -input=false -auto-approve

# 释放资源
terraform destroy

# 多环境部署
terraform workspace select QA
```

