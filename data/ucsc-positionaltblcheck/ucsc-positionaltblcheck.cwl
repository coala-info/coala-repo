cwlVersion: v1.2
class: CommandLineTool
baseCommand: positionalTblCheck
label: ucsc-positionaltblcheck
doc: "A tool to check that a table has positional information (chrom, chromStart,
  chromEnd). Note: The provided help text contains a container execution error and
  does not list specific arguments.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-positionaltblcheck:482--h0b57e2e_0
stdout: ucsc-positionaltblcheck.out
