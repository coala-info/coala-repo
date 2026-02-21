cwlVersion: v1.2
class: CommandLineTool
baseCommand: dbSnoop
label: ucsc-dbsnoop
doc: "The provided text does not contain help information for the tool. It consists
  of container runtime logs and a fatal error message indicating a failure to fetch
  or build the OCI image.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-dbsnoop:482--h0b57e2e_0
stdout: ucsc-dbsnoop.out
