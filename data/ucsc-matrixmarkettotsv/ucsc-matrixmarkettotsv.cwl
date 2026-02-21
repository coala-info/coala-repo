cwlVersion: v1.2
class: CommandLineTool
baseCommand: ucsc-matrixmarkettotsv
label: ucsc-matrixmarkettotsv
doc: "The provided text does not contain help information as it is an error log from
  a container runtime (Apptainer/Singularity) failing to fetch the image. No arguments
  could be parsed from the input.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-matrixmarkettotsv:482--h0b57e2e_0
stdout: ucsc-matrixmarkettotsv.out
