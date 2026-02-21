cwlVersion: v1.2
class: CommandLineTool
baseCommand: parasol
label: ucsc-parahub_parasol
doc: "The provided text does not contain help information for the tool, but rather
  container runtime logs indicating a failure to fetch or build the OCI image.\n\n
  Tool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-parahub:469--h664eb37_1
stdout: ucsc-parahub_parasol.out
