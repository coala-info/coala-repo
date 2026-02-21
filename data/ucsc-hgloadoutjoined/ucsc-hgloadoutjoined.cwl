cwlVersion: v1.2
class: CommandLineTool
baseCommand: ucsc-hgloadoutjoined
label: ucsc-hgloadoutjoined
doc: "The provided text does not contain help information or usage instructions. It
  consists of container runtime logs and a fatal error message indicating a failure
  to fetch or build the OCI image.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hgloadoutjoined:482--h0b57e2e_0
stdout: ucsc-hgloadoutjoined.out
