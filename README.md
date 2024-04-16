# terraform-google-solution-builder-external-application-load-balancer

## Description
### Tagline
A load balancer distributes user traffic across multiple instances of your applications.

### Detailed
This composition unit creates an L7 external HTTP application load balancer. The backends can be GCE VMs managed instance groups or cloud run services. Note that the backends cannot be a mix of MIGs and cloud run services.

The resources/services/activations/deletions that this module will create/trigger are:
- Network Endpoint Groups (NEGs) in case the backends are cloud run services.
- Backend service with the backends as MIGs or NEGs.
- A URL map that maps the traffic from Load balancer to the backend service.
- An HTTP proxy that acts as a proxy from external traffic and redirects it to backend service.
- Load balancer frontend that exposes an IP address and sends the traffic received on the IP address to the HTTP proxy.

### PreDeploy
To deploy this blueprint you must have an active billing account and billing permissions.

## Documentation
- [Load Balancer](https://cloud.google.com/load-balancing/docs/load-balancing-overview)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cloud\_run\_service\_names | List of cloud run services that need to be load balanced | `list(string)` | `[]` | no |
| cloud\_run\_service\_regions | List of regions that the cloud run services are deployed to | `list(string)` | `[]` | no |
| load\_balancer\_name | Name of the load balancer to be created | `string` | n/a | yes |
| load\_balancer\_port\_name | Name of backend port. The same name should appear in the GCE VM instance group that is being load balanced | `string` | `null` | no |
| managed\_instance\_group\_health\_check\_links | List of health check links of GCE VMs MIGs that are being load balanced | `list(string)` | `[]` | no |
| managed\_instance\_group\_urls | List of GCE VMs managed instance groups URLs | `list(string)` | `[]` | no |
| project\_id | The project ID where the load balancer is created | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| load\_balancer\_ip | IP address of the load balancer |
| load\_balancer\_port | Load balancer port |
| module\_dependency | Dependency variable that can be used by other modules to depend on this module |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- [Terraform][terraform] v0.13
- [Terraform Provider for GCP][terraform-provider-gcp] plugin v3.0

### Service Account

A service account with the following roles must be used to provision
the resources of this module:

- Compute Load Balancer Admin: `roles/compute.loadBalancerAdmin`

The [Project Factory module][project-factory-module] and the
[IAM module][iam-module] may be used in combination to provision a
service account with the necessary roles applied.

## Contributing

Refer to the [contribution guidelines](./CONTRIBUTING.md) for
information on contributing to this module.

[iam-module]: https://registry.terraform.io/modules/terraform-google-modules/iam/google
[project-factory-module]: https://registry.terraform.io/modules/terraform-google-modules/project-factory/google
[terraform-provider-gcp]: https://www.terraform.io/docs/providers/google/index.html
[terraform]: https://www.terraform.io/downloads.html

## Security Disclosures

Please see our [security disclosure process](./SECURITY.md).
