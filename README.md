# tf_aws_module

## 目录

| 文件名           | 说明                       |
| ---------------- | -------------------------- |
| provider.tf      | provide提供者              |
| terraform.tfvars | 配置 provider 要用到的变量 |
| varable.tf       | 通用变量                   |
| resource.tf      | 资源定义                   |
| data.tf          | 包文件定义                 |
| output.tf        | 输出                       |





## 基础命令

```shell
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



## 初始化报错

![image-20200916174143270](./images/image-20200916174143270.png)

https://releases.hashicorp.com/terraform-provider-aws/2.70.0/

找到自己系统对应的插件 下载好了之后运行 

```shell
terraform init -plugin-dir=/opt/terraform/plugins
```

