cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_pio_openmpi_5_0_6_mpifort
label: esme_pio_openmpi_5_0_6_mpifort
doc: "A component of the Energy Exascale Earth System Model (E3SM) or related climate
  modeling software, specifically the Parallel IO (PIO) library compiled with OpenMPI
  and Fortran support.\n\nTool homepage: https://github.com/NCAR/ParallelIO"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_pio_openmpi_5_0_6_mpifort.out
