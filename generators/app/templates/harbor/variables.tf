variable "harbor_url" {
  type = string
  default = <%- "\""+harborDomain+"\"" %>
}