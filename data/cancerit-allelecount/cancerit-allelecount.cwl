cwlVersion: v1.2
class: CommandLineTool
baseCommand: alleleCounter
label: cancerit-allelecount
doc: "A tool to count alleles in a BAM file at specific locations.\n\nTool homepage:
  https://github.com/cancerit/alleleCount"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cancerit-allelecount:4.3.0--h8bd2d3b_7
stdout: cancerit-allelecount.out
