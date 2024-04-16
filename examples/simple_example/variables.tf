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

variable "project_id" {
  type = string
  description = "The project ID where the load balancer is created"
}

variable "load_balancer_name" {
  type = string
  description = "Name of the load balancer to be created"
}

variable "cloud_run_service_names" {
  type = list(string)
  default = []
  description = "List of cloud run services that need to be load balanced"
}

variable "cloud_run_service_regions" {
  type = list(string)
  default = []
  description = "List of regions that the cloud run services are deployed to"
}
