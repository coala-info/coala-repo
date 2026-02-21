cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslCheck
label: ucsc-psltopslx_pslCheck
doc: "Check PSL files for validity. (Note: The provided help text contained container
  runtime errors and did not include usage information.)\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-psltopslx:482--h0b57e2e_0
stdout: ucsc-psltopslx_pslCheck.out
