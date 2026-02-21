cwlVersion: v1.2
class: CommandLineTool
baseCommand: nc-config
label: esme_netcdf-c_psmpi_5_12_1_nc-config
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log related to a container build failure (no space left on
  device).\n\nTool homepage: http://www.unidata.ucar.edu/software/netcdf/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_netcdf-c_psmpi_5_12_1_nc-config.out
