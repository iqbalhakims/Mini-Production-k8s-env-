output "controlplane_ip" {
  value = aws_instance.controlplane.public_ip
}

output "worker_ips" {
  value = aws_instance.workers[*].public_ip
}
