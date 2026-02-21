cwlVersion: v1.2
class: CommandLineTool
baseCommand: repeatafterme
label: repeatafterme
doc: "A tool for identifying and analyzing repetitive elements in genomic sequences.\n
  \nTool homepage: https://github.com/Dfam-consortium/RepeatAfterMe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/repeatafterme:0.0.7--h7b50bb2_0
stdout: repeatafterme.out
