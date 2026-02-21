cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedRemoveOverlap
label: ucsc-bedremoveoverlap
doc: "A tool to remove overlapping items from a BED file. (Note: The provided help
  text contains system error messages regarding a container build failure and does
  not list command-line arguments.)\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedremoveoverlap:482--h0b57e2e_0
stdout: ucsc-bedremoveoverlap.out
