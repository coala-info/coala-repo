cwlVersion: v1.2
class: CommandLineTool
baseCommand: mpirun
label: esme_netcdf-fortran_openmpi_5_0_6_mpirun
doc: "Earth System Model Evaluation (ESME) tool with NetCDF-Fortran and OpenMPI support.\n
  \nTool homepage: http://www.unidata.ucar.edu/software/netcdf/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_netcdf-fortran_openmpi_5_0_6_mpirun.out
