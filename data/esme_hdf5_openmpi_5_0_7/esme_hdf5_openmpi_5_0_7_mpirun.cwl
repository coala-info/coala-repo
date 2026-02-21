cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_hdf5_openmpi_5_0_7_mpirun
label: esme_hdf5_openmpi_5_0_7_mpirun
doc: "Energy Exascale Earth System Model (E3SM) component (Note: The provided text
  contains container runtime error messages rather than tool help documentation).\n
  \nTool homepage: https://www.hdfgroup.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_hdf5_openmpi_5_0_7_mpirun.out
