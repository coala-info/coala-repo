cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslCheck
label: ucsc-chaintopsl_pslCheck
doc: "Check PSL files for correctness. (Note: The provided help text contains container
  runtime errors and does not list command-line arguments.)\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chaintopsl:482--h0b57e2e_0
stdout: ucsc-chaintopsl_pslCheck.out
