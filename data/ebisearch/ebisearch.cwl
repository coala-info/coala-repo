cwlVersion: v1.2
class: CommandLineTool
baseCommand: ebisearch
label: ebisearch
doc: "EBI Search CLI tool (Note: The provided text contains only container runtime
  error messages and no help documentation.)\n\nTool homepage: https://github.com/ebi-wp/EBISearch-webservice-clients"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ebisearch:0.0.3--py27_1
stdout: ebisearch.out
