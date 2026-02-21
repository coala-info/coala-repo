cwlVersion: v1.2
class: CommandLineTool
baseCommand: twoBitDup
label: ucsc-twobitdup_twoBitDup
doc: "Check for duplicate sequences in a .2bit file. (Note: The provided help text
  contains only system error messages and no usage information; arguments could not
  be extracted from the source text.)\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-twobitdup:482--h0b57e2e_0
stdout: ucsc-twobitdup_twoBitDup.out
