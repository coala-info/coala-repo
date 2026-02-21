cwlVersion: v1.2
class: CommandLineTool
baseCommand: headRest
label: ucsc-headrest_headRest
doc: "The provided text does not contain help information for the tool. It contains
  container runtime logs and a fatal error message indicating a failure to fetch or
  build the container image.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-headrest:482--h0b57e2e_0
stdout: ucsc-headrest_headRest.out
