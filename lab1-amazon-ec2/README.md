


# 只能创建1台EC2实例

1、通过默认VPC创建EC2机器
2、创建eip
3、创建安全组
4、导入自定义key
5、打开ICMP


注意！



usage

```
terraform init
terraform plan 
terraform apply
terraform destroy
```

```
➜  ~ ssh -i .ssh/15b883 ec2-user@35.73.71.119
The authenticity of host '35.73.71.119 (35.73.71.119)' can't be established.
ECDSA key fingerprint is SHA256:jdw9rgV1FKZ2bjrVhNSpEjLy68Wh2tz5Gu7fcP/SJfA.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '35.73.71.119' (ECDSA) to the list of known hosts.

       __|  __|_  )
       _|  (     /   Amazon Linux 2 AMI
      ___|\___|___|

https://aws.amazon.com/amazon-linux-2/
[ec2-user@ip-172-31-38-131 ~]$
[ec2-user@ip-172-31-38-131 ~]$
```