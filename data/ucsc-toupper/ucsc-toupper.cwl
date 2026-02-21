cwlVersion: v1.2
class: CommandLineTool
baseCommand: toupper
label: ucsc-toupper
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed container build/fetch process.\n\n
  Tool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-toupper:482--h0b57e2e_0
stdout: ucsc-toupper.out
