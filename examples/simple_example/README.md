# Simple Example

This example illustrates how to use the `solution-builder-external-application-load-balancer` module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cloud\_run\_service\_names | List of cloud run services that need to be load balanced | `list(string)` | `[]` | no |
| cloud\_run\_service\_regions | List of regions that the cloud run services are deployed to | `list(string)` | `[]` | no |
| load\_balancer\_name | Name of the load balancer to be created | `string` | n/a | yes |
| project\_id | The project ID where the load balancer is created | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| load\_balancer\_ip | IP address of the load balancer |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

To provision this example, run the following from within this directory:
- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure
