cwlVersion: v1.2
class: CommandLineTool
baseCommand: parasol
label: ucsc-para_parasol
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
    dockerPull: quay.io/biocontainers/ucsc-para:469--h664eb37_1
stdout: ucsc-para_parasol.out
