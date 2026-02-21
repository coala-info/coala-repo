cwlVersion: v1.2
class: CommandLineTool
baseCommand: haploview
label: haploview
doc: "Haploview is a tool for haplotype analysis and visualization. (Note: The provided
  text contains only system error messages and no help documentation.)\n\nTool homepage:
  https://www.broadinstitute.org/haploview/haploview"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haploview:4.2--hdfd78af_1
stdout: haploview.out
