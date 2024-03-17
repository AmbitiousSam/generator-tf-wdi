variable "docker_repository_name" {
  description = "Docker Hub Namespace containing repositories"
  type        = string
  default     = "<%- dockerRepositoryName %>"
}
variable "harbor_url" {
  type = string
  description = "Harbor Url"
  default = "<%- harborDomain -%>"
}