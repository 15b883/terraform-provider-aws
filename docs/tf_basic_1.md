##  Terraform基础概念 

使用terraform的第一步是配置要使用的提供商创建一个空文件夹，并在其中创建名为main.tf的文件，文件内容如下

```
provider "aws" {
    profile = "default"
    region  = "ap-northeast-1"
}
```

表示： 

1、此配置告诉terraform 将使用AWS作为服务提供商

terraform提供很多服务商 https://registry.terraform.io/browse/providers

2、将基础设施部署到ap-northeast-1区域 

3、使用AWSCLI默认的配置凭证（也可单独配置AKSK）

对于每种类型的服务提供商，你可以创建许多不同种类的资源。例如服务器、数据库、负载均衡器等等

创建资源的语法如下：

```
resource "<PROVIDER>_<TYPE>" "NAME" {
    [CONFIG]
}
```

PROVIDER是服务提供商的名称（例如AWS） 

TYPE是在该提供商中创建的资源类型（例如instance） 

NAME是一个标识符，可以在整个terraform代码块范围内通过这个标识符引用该资源（例如example）

CONFIG包含一个或者多个特定于该资源的参数或参数组

**举个栗子：在AWS提供商中创建EC2实例**

```
resource "aws_instance" "example" {
    ami           = "ami-0bc8ae3ec8e338cbc"
    instance_type = "t2.micro"
}    
```

表示： aws_instance 资源包含多个不同的参数。但是只有两个参数是必须设置的

 ami  

> 运行在EC2实例商的Amazon Machine Image（AMI）。可以在AWS Marketplace中查询免费或付费的AMI 

instance_type  

> AWS EC2运行实例的类型。每种类型的EC2实例都提供不同数量的CPU、内存、磁盘空间和网络带宽。 t2.micro 型号属于AWS免费套餐的一部分

## terraform init

打开终端，进入创建main.tf的文件夹，然后运行`terraform init`命令

```
➜  lab0-Demo git:(master) ✗ terraform init

Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/aws...
- Installing hashicorp/aws v3.33.0...
- Installed hashicorp/aws v3.33.0 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

terraform可执行文件包含terraform的基本功能，但是它不包含任何服务提供商（AWS、Azure、GCP等等）的代码，所以第一次使用terraform时，需要运行`terraform init` 命令。指示terraform扫描代码，找出使用的服务提供商，并下载它们需要使用的代码库。

默认情况下服务提供商的代码会被下载到`.terraform`目录下

每次在使用新的terraform代码时，都需要先运行`terraform init` 命令（命令时幂等的）。

## terraform plan

运行`terraform plan`命令，进行预览

```
➜  lab0-Demo git:(master) ✗ terraform plan

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.example will be created
  + resource "aws_instance" "example" {
      + ami                          = "ami-0bc8ae3ec8e338cbc"
      + arn                          = (known after apply)
      + associate_public_ip_address  = (known after apply)
      + availability_zone            = (known after apply)
      + cpu_core_count               = (known after apply)
      + cpu_threads_per_core         = (known after apply)
      + get_password_data            = false
      + host_id                      = (known after apply)
      + id                           = (known after apply)
      + instance_state               = (known after apply)
      + instance_type                = "t2.micro"
      + ipv6_address_count           = (known after apply)
      + ipv6_addresses               = (known after apply)
      + key_name                     = (known after apply)
      + outpost_arn                  = (known after apply)
      + password_data                = (known after apply)
      + placement_group              = (known after apply)
      + primary_network_interface_id = (known after apply)
      + private_dns                  = (known after apply)
      + private_ip                   = (known after apply)
      + public_dns                   = (known after apply)
      + public_ip                    = (known after apply)
      + secondary_private_ips        = (known after apply)
      + security_groups              = (known after apply)
      + source_dest_check            = true
      + subnet_id                    = (known after apply)
      + tenancy                      = (known after apply)
      + vpc_security_group_ids       = (known after apply)

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + tags                  = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + enclave_options {
          + enabled = (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      + metadata_options {
          + http_endpoint               = (known after apply)
          + http_put_response_hop_limit = (known after apply)
          + http_tokens                 = (known after apply)
        }

      + network_interface {
          + delete_on_termination = (known after apply)
          + device_index          = (known after apply)
          + network_interface_id  = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + tags                  = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.
```

`terraform plan`命令可以在更改之前对于terraform进行预览，以便代码在发布给外界之前进行最后的检查。

`terraform plan`命令的输出类似于`diff`命令的输出

加号（+）代表任何新添加的内容

减号（-）代表删除的内容

波浪号（~）代表所有将被修改的内容

## terraform apply

创建实例的命令

```
➜  lab0-Demo git:(master) ✗ terraform apply

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.example will be created
  + resource "aws_instance" "example" {
      + ami                          = "ami-0bc8ae3ec8e338cbc"
      + arn                          = (known after apply)
      + associate_public_ip_address  = (known after apply)
      + availability_zone            = (known after apply)
      + cpu_core_count               = (known after apply)
      + cpu_threads_per_core         = (known after apply)
      + get_password_data            = false
      + host_id                      = (known after apply)
      + id                           = (known after apply)
      + instance_state               = (known after apply)
      + instance_type                = "t2.micro"
      + ipv6_address_count           = (known after apply)
      + ipv6_addresses               = (known after apply)
      + key_name                     = (known after apply)
      + outpost_arn                  = (known after apply)
      + password_data                = (known after apply)
      + placement_group              = (known after apply)
      + primary_network_interface_id = (known after apply)
      + private_dns                  = (known after apply)
      + private_ip                   = (known after apply)
      + public_dns                   = (known after apply)
      + public_ip                    = (known after apply)
      + secondary_private_ips        = (known after apply)
      + security_groups              = (known after apply)
      + source_dest_check            = true
      + subnet_id                    = (known after apply)
      + tenancy                      = (known after apply)
      + vpc_security_group_ids       = (known after apply)

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + tags                  = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + enclave_options {
          + enabled = (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      + metadata_options {
          + http_endpoint               = (known after apply)
          + http_put_response_hop_limit = (known after apply)
          + http_tokens                 = (known after apply)
        }

      + network_interface {
          + delete_on_termination = (known after apply)
          + device_index          = (known after apply)
          + network_interface_id  = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + tags                  = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_instance.example: Creating...
aws_instance.example: Still creating... [10s elapsed]
aws_instance.example: Still creating... [20s elapsed]
aws_instance.example: Creation complete after 26s [id=i-0f97579105edd3fb5]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

apply与plan命令显示的会一模一样，并要求确认是否要继续执行该计划。因此虽然plan是一个单独的命令，但是 它的主要应用场景是快速完整性检查以及代码评审。

输入yes后，确认创建EC2实例。

**控制台检查**

通过上面输出信息得出创建到实例的ID为id=i-0f97579105edd3fb5与下面控制台的实例ID一样

![image-20210324142951185](https://i.loli.net/2021/03/24/C4PEA9uSONnmTG5.png)

**创建实例名称，修改代码**

```
provider "aws" {
    profile = "jp"
    region  = "ap-northeast-1"
}

resource "aws_instance" "example" {
    ami           = "ami-0bc8ae3ec8e338cbc"
    instance_type = "t2.micro"

    tags = {
        Name = "example"
    }
}
```

 再次执行apply

```
➜  lab0-Demo git:(master) ✗ terraform apply
aws_instance.example: Refreshing state... [id=i-0f97579105edd3fb5]

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  ~ update in-place

Terraform will perform the following actions:

  # aws_instance.example will be updated in-place
  ~ resource "aws_instance" "example" {
        id                           = "i-0f97579105edd3fb5"
      ~ tags                         = {
          + "Name" = "example"
        }
        # (26 unchanged attributes hidden)




        # (4 unchanged blocks hidden)
    }

Plan: 0 to add, 1 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_instance.example: Modifying... [id=i-0f97579105edd3fb5]
aws_instance.example: Modifications complete after 3s [id=i-0f97579105edd3fb5]

Apply complete! Resources: 0 added, 1 changed, 0 destroyed.
```

控制台再次检查

Name这一栏添加example

![image-20210324143340224](https://i.loli.net/2021/03/24/flYnHM4Ea8SrRwG.png)

## terraform destroy

删除资源

```
➜  lab0-Demo git:(master) ✗ terraform destroy

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # aws_instance.example will be destroyed
  - resource "aws_instance" "example" {
      - ami                          = "ami-0bc8ae3ec8e338cbc" -> null
      - arn                          = "arn:aws:ec2:ap-northeast-1:610583805770:instance/i-0f97579105edd3fb5" -> null
      - associate_public_ip_address  = true -> null
      - availability_zone            = "ap-northeast-1c" -> null
      - cpu_core_count               = 1 -> null
      - cpu_threads_per_core         = 1 -> null
      - disable_api_termination      = false -> null
      - ebs_optimized                = false -> null
      - get_password_data            = false -> null
      - hibernation                  = false -> null
      - id                           = "i-0f97579105edd3fb5" -> null
      - instance_state               = "running" -> null
      - instance_type                = "t2.micro" -> null
      - ipv6_address_count           = 0 -> null
      - ipv6_addresses               = [] -> null
      - monitoring                   = false -> null
      - primary_network_interface_id = "eni-0fae9c04f3947c394" -> null
      - private_dns                  = "ip-172-31-7-172.ap-northeast-1.compute.internal" -> null
      - private_ip                   = "172.31.7.172" -> null
      - public_dns                   = "ec2-52-193-56-184.ap-northeast-1.compute.amazonaws.com" -> null
      - public_ip                    = "52.193.56.184" -> null
      - secondary_private_ips        = [] -> null
      - security_groups              = [
          - "default",
        ] -> null
      - source_dest_check            = true -> null
      - subnet_id                    = "subnet-ca3ddb90" -> null
      - tags                         = {
          - "Name" = "example"
        } -> null
      - tenancy                      = "default" -> null
      - vpc_security_group_ids       = [
          - "sg-f5decdb4",
        ] -> null

      - credit_specification {
          - cpu_credits = "standard" -> null
        }

      - enclave_options {
          - enabled = false -> null
        }

      - metadata_options {
          - http_endpoint               = "enabled" -> null
          - http_put_response_hop_limit = 1 -> null
          - http_tokens                 = "optional" -> null
        }

      - root_block_device {
          - delete_on_termination = true -> null
          - device_name           = "/dev/xvda" -> null
          - encrypted             = false -> null
          - iops                  = 100 -> null
          - tags                  = {} -> null
          - throughput            = 0 -> null
          - volume_id             = "vol-0ccf293bab21f4b23" -> null
          - volume_size           = 8 -> null
          - volume_type           = "gp2" -> null
        }
    }

Plan: 0 to add, 0 to change, 1 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

aws_instance.example: Destroying... [id=i-0f97579105edd3fb5]
aws_instance.example: Still destroying... [id=i-0f97579105edd3fb5, 10s elapsed]
aws_instance.example: Still destroying... [id=i-0f97579105edd3fb5, 20s elapsed]
aws_instance.example: Still destroying... [id=i-0f97579105edd3fb5, 30s elapsed]
aws_instance.example: Still destroying... [id=i-0f97579105edd3fb5, 40s elapsed]
aws_instance.example: Destruction complete after 42s

Destroy complete! Resources: 1 destroyed.
```