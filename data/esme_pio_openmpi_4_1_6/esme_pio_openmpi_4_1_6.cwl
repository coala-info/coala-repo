cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_pio_openmpi_4_1_6
label: esme_pio_openmpi_4_1_6
doc: "ESME (Energy Exascale Earth System Model) component with PIO (Parallel IO) and
  OpenMPI support. Note: The provided help text contains only container runtime error
  messages and no usage information.\n\nTool homepage: https://github.com/NCAR/ParallelIO"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_pio_openmpi_4_1_6.out
