cwlVersion: v1.2
class: CommandLineTool
baseCommand: ucsc-headrest
label: ucsc-headrest
doc: "The provided text is a container runtime error log and does not contain help
  documentation for the tool. It indicates a failure to fetch or build the SIF image
  from the OCI registry.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-headrest:482--h0b57e2e_0
stdout: ucsc-headrest.out
