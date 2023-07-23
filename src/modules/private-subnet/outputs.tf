output "private_subnet_id" {
  description = "The IDs of the Private Subnet"
  #value       = aws_subnet.private_subnet[each.key].id
  #value       = concat(aws_subnet.private_subnet*.id, [""])[0]
  value = {
    for k, v in aws_subnet.private_subnet : k => v.id
  }
}

output "private_subnet_arn" {
  description = "The ARNs of the Private Subnet"
  value = {
    for k, v in aws_subnet.private_subnet : k => v.arn
  }
}

/* 
output "private_subnet_id_2" {
  description = "The ID of the Private Subnet 2"
  value       = concat(aws_subnet.private_subnet.*.id, [""])[1]
}

output "private_subnet_arn_1" {
  description = "The ARN of the Private Subnet 1"
  value       = concat(aws_subnet.private_subnet.*.arn, [""])[0]
}

output "private_subnet_arn_2" {
  description = "The ARN of the Private Subnet 2"
  value       = concat(aws_subnet.private_subnet.*.arn, [""])[1]
} */
