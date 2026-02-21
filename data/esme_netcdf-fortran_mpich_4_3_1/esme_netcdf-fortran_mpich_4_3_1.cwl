cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_netcdf-fortran_mpich_4_3_1
label: esme_netcdf-fortran_mpich_4_3_1
doc: "The provided text does not contain help information or usage instructions; it
  contains system logs and a fatal error regarding container image creation (no space
  left on device).\n\nTool homepage: http://www.unidata.ucar.edu/software/netcdf/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_netcdf-fortran_mpich_4_3_1.out
