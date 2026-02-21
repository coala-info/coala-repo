cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme
label: esme_netcdf-fortran_openmpi_5_0_6
doc: "Earth System Model Evaluation (ESME) tool. Note: The provided help text contains
  only system error logs regarding container image conversion and disk space issues,
  and does not list specific command-line arguments.\n\nTool homepage: http://www.unidata.ucar.edu/software/netcdf/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_netcdf-fortran_openmpi_5_0_6.out
