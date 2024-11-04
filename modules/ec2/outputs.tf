output "hazelcast_servers1_ip" {
  value = aws_instance.hazelcast-servers[0].private_ip     
}

output "elkserver_ip" {
  value = aws_instance.elkserver.private_ip
}
output "grafana-server_ips" {
  value = aws_instance.grafana-server.private_ip
}

output "kube-server_ips" {
  value = aws_instance.kube-server.private_ip
}
output "bastion-server-ip" {
  value = aws_instance.bastion-server.private_ip
}


/*output "mongo_message_servers_ips" {
  value = {
      for server in aws_instance.mongo-servers:
      server.id => server.private_ip
  }
}
output "mongo_analytics_servers_ips" {
  value = {
      for server in aws_instance.mongo-analytics-servers:
      server.id => server.private_ip
  }
}
output "mongo_rest_servers_ips" {
  value = {
      for server in aws_instance.mongo-rest-servers:
      server.id => server.private_ip
  }
}*/

output "mongo_opsmanager_server_ip" {
  value = aws_instance.opsmanager-server.private_ip
}
output "rmq_server1_ip" {
  value = aws_instance.rmqserver[0].private_ip     
}
output "rmq_server2_ip" {
  value = aws_instance.rmqserver[1].private_ip     
}
output "postgresql-server" {
  value = aws_instance.postgresql-server.private_ip   
}






/*
#########
output "instance_name" {
   description = "Tags of the EC2 instance"
-  value        = aws_instance.web_app.tags
+  value        = [for instance in aws_instance.web_app: instance.tags.Name]
}*/
