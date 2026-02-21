cwlVersion: v1.2
class: CommandLineTool
baseCommand: h5dump
label: esme_openmpi_5_0_6_h5dump
doc: "HDF5 dump utility (Note: The provided help text contains only container runtime
  error messages and no usage information).\n\nTool homepage: https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_openmpi_5_0_6_h5dump.out
