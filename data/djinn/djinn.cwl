cwlVersion: v1.2
class: CommandLineTool
baseCommand: djinn
label: djinn
doc: "A tool for processing genomic data (description not provided in help text)\n
  \nTool homepage: https://github.com/pdimens/djinn"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/djinn:2.0--pyhdfd78af_0
stdout: djinn.out
