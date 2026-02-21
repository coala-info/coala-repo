cwlVersion: v1.2
class: CommandLineTool
baseCommand: seidr
label: seidr
doc: "A toolkit for gene regulatory network inference and community discovery.\n\n
  Tool homepage: https://github.com/bschiffthaler/seidr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seidr:0.14.2--mpi_openmpi_h1d478e8
stdout: seidr.out
