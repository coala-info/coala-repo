cwlVersion: v1.2
class: CommandLineTool
baseCommand: matrixToBarChartBed
label: ucsc-matrixtobarchartbed
doc: "A tool to convert a matrix file to a bar chart BED file. (Note: The provided
  help text contains only system error messages and no argument information.)\n\n
  Tool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-matrixtobarchartbed:482--h0b57e2e_0
stdout: ucsc-matrixtobarchartbed.out
