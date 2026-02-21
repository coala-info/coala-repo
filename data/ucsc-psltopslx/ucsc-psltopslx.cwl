cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslToPslx
label: ucsc-psltopslx
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains container runtime error messages indicating a failure to fetch
  or build the image.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-psltopslx:482--h0b57e2e_0
stdout: ucsc-psltopslx.out
