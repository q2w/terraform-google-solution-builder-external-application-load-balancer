/**
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

output "load_balancer_ip" {
  description = "IP address of the load balancer"
  value       = google_compute_global_forwarding_rule.main.ip_address
}

output "load_balancer_port" {
  description = "Load balancer port"
  value = google_compute_global_forwarding_rule.main.port_range
}

output "module_dependency" {
  value = {}
  depends_on = [google_compute_backend_service.main, google_compute_global_address.main, google_compute_global_forwarding_rule.main, google_compute_region_network_endpoint_group.main, google_compute_target_http_proxy.main, google_compute_url_map.main]
  description = "Dependency variable that can be used by other modules to depend on this module"
}
