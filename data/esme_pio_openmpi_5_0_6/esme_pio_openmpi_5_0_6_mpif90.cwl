cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_pio_openmpi_5_0_6_mpif90
label: esme_pio_openmpi_5_0_6_mpif90
doc: "A component of the ESME (Energy Exascale Earth System Model) suite utilizing
  the Parallel IO (PIO) library, compiled with OpenMPI and the Fortran 90 compiler.\n
  \nTool homepage: https://github.com/NCAR/ParallelIO"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_pio_openmpi_5_0_6_mpif90.out
