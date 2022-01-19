#Deploying cluster autoscaler in k8s cluster
resource "helm_release" "cluster_autoscaler" {
  name       = "cluster-autoscaler"
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"
  namespace  = "kube-system"

  set {
    name  = "autoDiscovery.clusterName"
    value = var.cluster_name
  }

  set {
    name  = "awsRegion"
    value = var.region
  }

  depends_on = [module.eks_cluster]
}

#Deploying ingress controller in k8s cluster
resource "helm_release" "ingress_controller" {
  name             = "ingress-controller"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  create_namespace = true
  namespace        = "ingress-nginx"

  depends_on = [module.eks_cluster, helm_release.cluster_autoscaler]
}

#Deploying metrics server in k8s cluster
resource "helm_release" "metrics_server" {
  name       = "metrics-server"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "metrics-server"
  namespace  = "kube-system"

  set {
    name  = "apiService.create"
    value = true
  }

  depends_on = [module.eks_cluster, helm_release.cluster_autoscaler]
}
