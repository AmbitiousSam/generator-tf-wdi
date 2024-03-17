resource "helm_release" "harbor" {
  name       = "my-harbor"
  repository = "https://helm.goharbor.io"
  timeout    = 120
  chart      = "harbor"
  version    = "1.14.0"
  create_namespace = true
  cleanup_on_fail  = true
  force_update     = false
  
  values = [file("./resources/values.yml")]
}

resource "null_resource" "name" {
  provisioner "local-exec" {
    command = "export CERT_INGRESS=${helm_release.harbor.name} && chmod +x ./harbor-cert-setup.sh && ./harbor-cert-setup.sh --minikube"
  }
  depends_on = [ helm_release.harbor ]
}

resource "null_resource" "print_domain_name" {
  
provisioner "local-exec" {
  command = <<-EOT
  echo "https://core.harbor.domain is your harbor domain";
  echo "Harbor Username = 'admin' is your harbor username";
  echo "admin" >> harbor-credentials.txt;
  echo "Harbor12345 >> harbor-credentials.txt"
  echo "Harbor Password = 'Harbor12345' is your harbor password";
  echo "To Setup Harbor Certificates run the command 'harbor-cert-setup.sh --local' in the same directory with sudo privileges";
  EOT
}
  depends_on = [ helm_release.harbor ]
}