cwlVersion: v1.2
class: CommandLineTool
baseCommand: cgview
label: cgview
doc: "A tool for generating high-quality, interactive maps of circular genomes.\n\n
  Tool homepage: http://wishart.biology.ualberta.ca/cgview/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cgview:1.0--py35pl5.22.0_1
stdout: cgview.out
