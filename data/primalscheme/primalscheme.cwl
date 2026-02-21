cwlVersion: v1.2
class: CommandLineTool
baseCommand: primalscheme
label: primalscheme
doc: "A tool for multiplex primer design for whole genome sequencing\n\nTool homepage:
  https://github.com/aresti/primalscheme"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/primalscheme:1.4.1--pyh7cba7a3_0
stdout: primalscheme.out
