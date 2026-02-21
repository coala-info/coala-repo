cwlVersion: v1.2
class: CommandLineTool
baseCommand: roadies
label: roadies
doc: "A tool for processing genomic data (description not provided in help text)\n
  \nTool homepage: https://github.com/TurakhiaLab/ROADIES"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/roadies:0.1.10--py39pl5321h5ca1c30_0
stdout: roadies.out
