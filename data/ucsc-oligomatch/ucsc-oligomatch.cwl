cwlVersion: v1.2
class: CommandLineTool
baseCommand: ucsc-oligomatch
label: ucsc-oligomatch
doc: "The provided text does not contain help information or usage instructions; it
  is a log of a failed container build process.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-oligomatch:482--h0b57e2e_0
stdout: ucsc-oligomatch.out
