<%_ appFolders.forEach((appFolder, index) =>  { _%>
resource "harbor_project" "harbor_project_<%- appFolder.toLowerCase() %>" {
    name = "<%- appFolder.toLowerCase() %>"
    public                      = false               
    vulnerability_scanning      = true                
    enable_content_trust        = true               
    enable_content_trust_cosign = false
}
<%_ }) _%>