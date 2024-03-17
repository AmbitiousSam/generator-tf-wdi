const fileListEks = [
  "auto-destroy.sh",
  "auto-deploy.sh",
  "install.sh",
  "destroy.sh",
  "terraform-install.sh",
  "README.md",
  "eks/00-variables.tf",
  "eks/01-provider.tf",
  "eks/02-vpc.tf",
  "eks/03-iam-role-eks.tf",
  "eks/04-cluster.tf",
  "eks/05-iam-role-worker.tf",
  "eks/06-node-group.tf",
  "eks/07-data-source.tf",
  "eks/08-kubeconfig.tf",
  "eks/09-identity-provider.tf",
  "eks/10-check-infra.tf"
];

const fileListEksDrivers = [
  "eks-drivers/main.tf",
  "eks-drivers/provider.tf",
  "eks-drivers/variables.tf"
];

const fileListEck = [
  "eck/resources/crds.yaml",
  "eck/resources/operator.yaml",
  "eck/00-variables.tf",
  "eck/01-provider.tf",
  "eck/02-operator.tf",
  "eck/03-elasticsearch.tf",
  "eck/04-kibana.tf",
  "eck/README.md"
];

const fileListECR = ["ecr/variables.tf", "ecr/provider.tf", "ecr/main.tf"];

const fileListEcrBuildAndPush = [
  "ecr-build&publish/00-variables.tf",
  "ecr-build&publish/01-provider.tf",
  "ecr-build&publish/02-build-image.tf",
  "ecr-build&publish/03-publish-image.tf",
  "ecr-build&publish/README.md"
];

const fileListHarbor = [
  "harbor/resources/values.yml",
  "harbor/main.tf",
  "harbor/provider.tf",
  "harbor/create-project.tf",
  "harbor/variables.tf",
  "harbor/harbor-cert-setup.sh"
];

const fileListIstio = [
  "istio/istio.tf",
  "istio/provider.tf",
  "istio/variables.tf"
];

const fileListNamespace = ["namespace/namespace.tf", "namespace/provider.tf"];

const fileListIstioMonitoring = [
  "istio-monitoring/variables.tf",
  "istio-monitoring/provider.tf",
  "istio-monitoring/main.tf",
  "istio-monitoring/README.md"
];

const fileListIstioMonitoringResources = [
  "istio-monitoring/resources/grafana.yaml",
  "istio-monitoring/resources/kiali.yaml",
  "istio-monitoring/resources/prometheus.yaml"
];

const fileListK8sWebUI = [
  "k8s-web-ui/provider.tf",
  "k8s-web-ui/main.tf",
  "k8s-web-ui/README.md"
];

const fileListAks = [
  "aks/00-variables.tf",
  "aks/01-provider.tf",
  "aks/02-main.tf",
  "aks/03-kubeconfig.tf"
];

const fileListAcr = [
  "acr/00-variables.tf",
  "acr/01-provider.tf",
  "acr/02-main.tf"
];

const fileListAcrBuildAndPush = [
  "acr-build&publish/00-variables.tf",
  "acr-build&publish/01-provider.tf",
  "acr-build&publish/02-build-image.tf",
  "acr-build&publish/03-publish-image.tf",
  "acr-build&publish/README.md"
];

const fileListAzure = [
  "azure-auto-destroy.sh",
  "azure-auto-deploy.sh",
  "terraform-install.sh",
  "README.md"
];

const fileListGcp = [
  "gke/gke-cluster",
  "gke/kubernetes-config",
  "gke/outputs.tf",
  "gke/variables.tf",
  "gke/main.tf"
];

const fileListMinikube = [
  "minikube-auto-destroy.sh",
  "minikube-auto-deploy.sh"
];

const fileListDockerBuildAndPush = [
  "docker-build&publish/00-variables.tf",
  "docker-build&publish/01-provider.tf",
  "docker-build&publish/02-build-image.tf",
  "docker-build&publish/03-publish-image.tf",
  "docker-build&publish/README.md"
];

module.exports = {
  fileListEks,
  fileListEksDrivers,
  fileListEck,
  fileListGcp,
  fileListAks,
  fileListAcr,
  fileListAcrBuildAndPush,
  fileListAzure,
  fileListHarbor,
  fileListIstio,
  fileListNamespace,
  fileListECR,
  fileListEcrBuildAndPush,
  fileListIstioMonitoring,
  fileListIstioMonitoringResources,
  fileListK8sWebUI,
  fileListMinikube,
  fileListDockerBuildAndPush
};
