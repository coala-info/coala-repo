cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_psmpi_5_12_1_h5cc
label: esme_psmpi_5_12_1_h5cc
doc: "HDF5 C compiler wrapper. (Note: The provided help text contains only system
  error logs regarding container image creation and does not list command-line arguments.)\n
  \nTool homepage: https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_psmpi_5_12_1_h5cc.out
