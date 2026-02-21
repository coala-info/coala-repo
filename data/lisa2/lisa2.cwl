cwlVersion: v1.2
class: CommandLineTool
baseCommand: lisa2
label: lisa2
doc: "Epigenetic Landscape In Silico deletion Analysis\n\nTool homepage: https://genomebiology.biomedcentral.com/articles/10.1186/s13059-020-1934-6"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lisa2:2.3.2--pyhdfd78af_0
stdout: lisa2.out
