cwlVersion: v1.2
class: CommandLineTool
baseCommand: myriad
label: myriad
doc: "A tool for processing genomic data (description not provided in help text)\n
  \nTool homepage: https://github.com/cjw85/myriad"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/myriad:0.1.4--py27_0
stdout: myriad.out
