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

locals {
  cloud_run_services = [for i in range(length(var.cloud_run_service_names)) : {
    name   = var.cloud_run_service_names[i]
    region = var.cloud_run_service_regions[i]
  }]
}

resource "google_compute_region_network_endpoint_group" "main" {
  for_each = { for service in local.cloud_run_services : service.name => service }
  project               = var.project_id
  region                = each.value.region
  name                  = "${each.value.name}-neg"
  network_endpoint_type = "SERVERLESS"
  cloud_run {
    service = each.value.name
  }
}

resource "google_compute_backend_service" "main" {
  project               = var.project_id
  load_balancing_scheme = "EXTERNAL_MANAGED"
  name                  = "${var.load_balancer_name}-backend-service"
  port_name             = length(var.managed_instance_group_urls) > 0 ? var.load_balancer_port_name : null
  health_checks = length(var.managed_instance_group_health_check_links) > 0 ? [var.managed_instance_group_health_check_links[0]] : null
  dynamic "backend" {
    for_each = length(var.managed_instance_group_urls) > 0 ? { for idx, url in var.managed_instance_group_urls : tostring(idx) => url } : { for k, v in google_compute_region_network_endpoint_group.main : k => v.id }
    content {
      group = backend.value
    }
  }
}

resource "google_compute_global_forwarding_rule" "main" {
  project               = var.project_id
  load_balancing_scheme = "EXTERNAL_MANAGED"
  name                  = "${var.load_balancer_name}-frontend"
  ip_address            = google_compute_global_address.main.address
  port_range            = "80"
  target                = google_compute_target_http_proxy.main.self_link
}

resource "google_compute_global_address" "main" {
  project = var.project_id
  name = "${var.load_balancer_name}-http-ip"
}

resource "google_compute_target_http_proxy" "main" {
  project = var.project_id
  name    = "${var.load_balancer_name}-target-proxy"
  url_map = google_compute_url_map.main.self_link
}

resource "google_compute_url_map" "main" {
  project         = var.project_id
  default_service = google_compute_backend_service.main.self_link
  name            = var.load_balancer_name
}
