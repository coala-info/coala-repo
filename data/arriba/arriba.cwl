cwlVersion: v1.2
class: CommandLineTool
baseCommand: arriba
label: arriba
doc: "Arriba is a tool for the detection of gene fusions from RNA-Seq data. Note:
  The provided input text contains system error logs regarding a container build failure
  ('no space left on device') rather than the tool's help documentation. Consequently,
  no arguments could be extracted.\n\nTool homepage: https://github.com/suhrig/arriba"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/arriba:2.5.1--h87b9561_0
stdout: arriba.out
