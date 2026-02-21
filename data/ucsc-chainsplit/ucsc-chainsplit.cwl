cwlVersion: v1.2
class: CommandLineTool
baseCommand: chainSplit
label: ucsc-chainsplit
doc: "The provided text does not contain help information for the tool. It contains
  container runtime logs indicating a failure to fetch or build the OCI image.\n\n
  Tool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chainsplit:482--h0b57e2e_0
stdout: ucsc-chainsplit.out
