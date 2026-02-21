cwlVersion: v1.2
class: CommandLineTool
baseCommand: syny
label: syny
doc: "A tool for synteny analysis and visualization (Note: The provided text appears
  to be a container build log rather than help text, so no arguments could be extracted).\n
  \nTool homepage: https://github.com/PombertLab/SYNY"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/syny:1.3.1--py312pl5321h7e72e81_0
stdout: syny.out
