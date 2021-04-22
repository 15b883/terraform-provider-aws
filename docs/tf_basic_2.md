# 变量 (var)

为了使代码更DRY化和可配置化，terraform允许用户定义输入变量。

输入变量、输出变量

变量语法

```
varible "NAME" {
  [CONFIG ...]
}
```

变量声明包含3个参数：

## **description**

描述参数用来说明如何使用这个变量

## **default**

有多种方法可以为变量赋值，包含

命令行（-var）

```
terraform plan -var "server_port = 8080"
```

文件（-var-file）

环境变量（TF_VAR_<variable_name>）

```
export TF_VAR_server_port = 8080
```



## type

允许对用户输入的变量类型进行强制约束；

包含string、number、bool、list、map、set、object、tuple、any（默认约束类型为any）

### string

字符串

```
variable "map_example" {
  description = "an example of a map in terrform"
  type        = map(string)
  
  default     = {
    key1      = "value1"
    key2      = "value2"
    key3      = "value3"
  }
}
```

### number

数字

```
variable "number_example" {
  description = "an example of a number variable in terraform"
  type        = number
  default     =2
}
```

### list

列表为字符串

```
variable "list_example" {
  description = "an example of a list in terraform"
  type        = list
  default     = ["a","b","c"]
}
```

列表为数字

```
variable "list_number_example" {
  description = "an example of a number list in terraform"
  type        = list(number)
  default     = [1,2,3]
}
```

### 更加复杂的对象和元祖结构类型

```
variable "object_example" {
  description = "an example of a structural type in terraform"
  type        = object({
    name      = string
    age       = number
    tags      = list(string)
    enabled   = bool
  })
  default     = {
    name      = "value"
    age       = 18
    tags      = ["a","b","c"]
    enabled   = true
  }
}
```

注意：如果变量设置的与类型约束不匹配的值，terraform会报错

> name为字符串
>
> age为数字
>
> tags为字符串列表
>
> enabled为布尔值



例如在某个配置文件需要配置一个端口的变量

```
variable "server_port" {
    description = "The port the server will use for HTTP requests"
    type = number
}
```

如果没有输入默认的变量，执行plan或者apply会显示下面提示

```
# terraform plan
var.server_port
  The port the server will use for HTTP requests

  Enter a value: 
```

如果不想每次处理交互式提示，可以通过命令的形式为变量提供初始化

```
# export TF_VAR_server_port=8080  
# terraform plan
```

直接设定一个默认值

```
variable "server_port" {
    description = "The port the server will use for HTTP requests"
    type = number
    default = 8080
}
```

变量引用

语法如下

```
var.<VARIABLE_NAME>
```

具体配置

```
resource "aws_security_group" "instance" {
    name = "terraform-example-instance"

    ingress {
      cidr_blocks = [ "0.0.0.0/0" ]
      description = "mono"
      from_port = var.server_port
      protocol = "TCP"
      to_port = var.server_port
    }      
}
```

## 输出变量

语法

```
output "<NAME>" {
    value = <VALUE>
    [CONFIG]
}
```

```
output "public_ip" {
  value        = aws_instance.example.public_ip
  description  = "public ip"
}
```

注意 你要执行apply执行才会显示IP，如果执行plan会显示下面信息

```
Changes to Outputs:
  + public_ip = (known after apply)
```

正确output输入

```
Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

public_ip = "18.183.127.183"
```

可以将新创建的服务器的IP地址作为变量输出在命令行上，而不必跟以前一样，登录AWS控制台查看IP地址

或者

```
# terraform output public_ip
18.183.127.183
```