cwlVersion: v1.2
class: CommandLineTool
baseCommand: mktime
label: ucsc-mktime
doc: "The provided text does not contain help information for the tool. It contains
  container runtime error messages indicating a failure to fetch or build the OCI
  image.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-mktime:482--h0b57e2e_0
stdout: ucsc-mktime.out
