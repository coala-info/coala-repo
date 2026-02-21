cwlVersion: v1.2
class: CommandLineTool
baseCommand: wtv
label: wtv
doc: "A tool for visualizing or processing data (description not available in provided
  text)\n\nTool homepage: https://recetox.github.io/wtv/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wtv:0.1.0--pyhdfd78af_0
stdout: wtv.out
