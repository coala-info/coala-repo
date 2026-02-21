cwlVersion: v1.2
class: CommandLineTool
baseCommand: ebisearch_ebeye_requests.py
label: ebisearch_ebeye_requests.py
doc: "A tool for interacting with the EBI Search (EB-eye) REST API.\n\nTool homepage:
  https://github.com/ebi-wp/EBISearch-webservice-clients"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ebisearch:0.0.3--py27_1
stdout: ebisearch_ebeye_requests.py.out
