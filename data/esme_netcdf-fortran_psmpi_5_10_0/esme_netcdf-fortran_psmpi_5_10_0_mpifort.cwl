cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_netcdf-fortran_psmpi_5_10_0_mpifort
label: esme_netcdf-fortran_psmpi_5_10_0_mpifort
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to an Apptainer/Singularity container build failure
  (no space left on device).\n\nTool homepage: http://www.unidata.ucar.edu/software/netcdf/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_netcdf-fortran_psmpi_5_10_0_mpifort.out
