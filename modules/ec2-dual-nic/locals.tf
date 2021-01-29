locals {
#  is_t_instance_type = replace(var.instance_type, "/^t(2|3|3a){1}\\..*$/", "1") == "1" ? true : false
interfaces_per_instance = 2
instance_count          = 1

}