# Get each list item separately
output "vm_name_0" {
  description = "VM Name"
  value = google_compute_instance.myapp1[0].name
}

# Get each list item separately
output "vm_name_1" {
  description = "VM Name"
  value = google_compute_instance.myapp1[1].name
}

# Output - For Loop with List
output "for_output_list" {
  description = "For Loop with List"
  value = [
  for instance in google_compute_instance.myapp1:
    instance.name

  ]
}


# Output - For Loop with Map(dictionary)
output "for_output_map1" {
  description = "For Loop with Map"
  value = {
  for instance in google_compute_instance.myapp1:
    instance.name => instance.instance_id
    #ouput looks like this
//  "myapp-instance-1" = "1234567890123456789"
//  "myapp-instance-2" = "9876543210987654321"



  }
}

# Output - For Loop with Map Advanced
output "for_output_map2" {
  description = "For Loop with Map - Advanced"
  value = {
  for c, instance in google_compute_instance.myapp1:
    c => instance.name
  }
//  Out put like this
//  {
//  0 = "myapp-instance-0"
//  1 = "myapp-instance-1"
//}

}

# Output - For Loop with Map Advanced
output "for_output_map3" {
  description = "For Loop with Map - Advanced (Instance Name and Instance ID)"
  value = {for c, instance in google_compute_instance.myapp1: instance.name => instance.instance_id}
}

# VM External IPs
output "vm_external_ips" {
  description = "For Loop with Map - Advanced"
  value = {for c, instance in google_compute_instance.myapp1: c => instance.network_interface.0.access_config.0.nat_ip}
}

output "compute_zones" {
  description = "List of compute zones"
  value = data.google_compute_zones.available.names
}