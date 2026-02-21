cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_netcdf-c_openmpi_4_1_6
label: esme_netcdf-c_openmpi_4_1_6
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of system log messages and a fatal error related to container
  image conversion and disk space.\n\nTool homepage: http://www.unidata.ucar.edu/software/netcdf/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_netcdf-c_openmpi_4_1_6.out
