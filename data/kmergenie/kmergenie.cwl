cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmergenie
label: kmergenie
doc: "KmerGenie estimates the best k-mer length for genome de novo assembly.\n\nTool
  homepage: http://kmergenie.bx.psu.edu"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmergenie:1.7051--py27r40h077b44d_11
stdout: kmergenie.out
