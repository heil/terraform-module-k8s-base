# terraform-module-k8s-base

Provide base Helm charts for a given Kubernetes cluster in a consistent manner.

This Terraform module can be used to provision the following Helm charts:

- [cert-manager](https://github.com/helm/charts/tree/master/stable/cert-manager)
- [external-dns](https://github.com/helm/charts/tree/master/stable/external-dns)
- [kubernetes-dashboard](https://github.com/helm/charts/tree/master/stable/kubernetes-dashboard)
- [metrics-server](https://github.com/helm/charts/tree/master/stable/metrics-server)
- [nginx-ingress](https://github.com/helm/charts/tree/master/stable/nginx-ingress)

## Requirements

To work with the module the following programs must be installed:

- [terraform](https://learn.hashicorp.com/terraform/getting-started/install.html)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

A working configuration for `kubectl` is also required. The variable `"cluster_name"` **must be set** to the appropriate
`kubectl` context.

The module uses, amongst other, the
[Terraform Provider for Helm](https://github.com/terraform-providers/terraform-provider-helm). For documentation see:

https://www.terraform.io/docs/providers/helm/

## Usage

### Provider configuration

The module requires the configuration of the following Terraform providers:

```
provider "helm" {
  version = "~> 0.7"

  kubernetes {
    config_context = "test.k8s.example.com"
  }
}

provider "null" {
  version = "~> 2.0"
}

provider "template" {
  version = "~> 2.0"
}
```

### Example usage

The module can be used as follows:

```
module "k8s_base" {
  source       = "git::ssh://git@gitlab.olanis.de:terraform/terraform-module-k8s-base.git?ref=tags/v0.1.0"
  cluster_name = "test.k8s.example.com"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| chart\_enabled\_cert\_manager | Set to `"false"` to prevent the module from creating a `cert-manager` Helm release. | string | `"true"` | no |
| chart\_enabled\_external\_dns | Set to `"false"` to prevent the module from creating an `external-dns` Helm release. | string | `"true"` | no |
| chart\_enabled\_kubernetes\_dashboard | Set to `"false"` to prevent the module from creating a `kubernetes-dashboard` Helm release. | string | `"true"` | no |
| chart\_enabled\_metrics\_server | Set to `"false"` to prevent the module from creating a `metrics-server` Helm release. | string | `"true"` | no |
| chart\_enabled\_nginx\_ingress | Set to `"false"` to prevent the module from creating a `nginx-ingress` Helm release. | string | `"true"` | no |
| chart\_namespace\_cert\_manager | The namespace where the `kubernetes-dashboard` Helm chart will be installed. | string | `"cert-manager"` | no |
| chart\_namespace\_external\_dns | The namespace where the `external-dns` Helm chart will be installed. | string | `"external-dns"` | no |
| chart\_namespace\_kube2iam | The namespace where the `kube2iam` Helm chart will be installed. | string | `"kube-system"` | no |
| chart\_namespace\_kubernetes\_dashboard | The namespace where the `kubernetes-dashboard` Helm chart will be installed. | string | `"kube-system"` | no |
| chart\_namespace\_metrics\_server | The namespace where the `metrics-server` Helm chart will be installed. | string | `"kube-system"` | no |
| chart\_namespace\_nginx\_ingress | The namespace where the `nginx-ingress` Helm chart will be installed. | string | `"nginx-ingress"` | no |
| chart\_version\_cert\_manager | The version of the `cert-manager` Helm chart to install. | string | `"v0.5.2"` | no |
| chart\_version\_external\_dns | The version of the `external-dns` Helm chart to install. | string | `"1.6.0"` | no |
| chart\_version\_kubernetes\_dashboard | The version of the `kubernetes-dashboard` Helm chart to install. | string | `"1.2.0"` | no |
| chart\_version\_metrics\_server | The version of the `metrics-server` Helm chart to install. | string | `"2.2.0"` | no |
| chart\_version\_nginx\_ingress | The version of the `nginx-ingress` Helm chart to install. | string | `"1.2.2"` | no |
| cluster\_name | The name of the Kubernetes cluster where the module will create resources. | string | n/a | **yes** |
| enabled | Set to `"false"` to prevent the module from creating any resources. | string | `"true"` | no |

## Troubleshooting

### Failure to create Helm release after failed run

Sometimes the `cert-manager` Helm release fails to create for some reason... When trying to create it again, an error is
thrown, stating that Kubernetes custom resources definitions cannot be created because they already exist. In that case
it is necessary to delete the CRD's before creating the Helm release again:

```
kubectl delete crd --context ${cluster_name} certificates.certmanager.k8s.io
kubectl delete crd --context ${cluster_name} clusterissuers.certmanager.k8s.io
kubectl delete crd --context ${cluster_name} issuers.certmanager.k8s.io
```

## Versioning

[Semantic versioning](http://semver.org/) is used to freeze module releases. For the versions available, see the tags on
this repository.

## Authors

* **Tarak Blah** - *Initial work*
