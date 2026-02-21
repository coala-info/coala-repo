cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pubmlst_client
  - list
label: pubmlst_client_pubmlst_list
doc: "List available schemes or datasets from the PubMLST database.\n\nTool homepage:
  https://github.com/Public-Health-Bioinformatics/pubmlst_client"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pubmlst_client:0.2.0--py_0
stdout: pubmlst_client_pubmlst_list.out
