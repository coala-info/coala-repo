cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_pio_mvapich_4_0_ucx
label: esme_pio_mvapich_4_0_ucx
doc: "ESME (Energy Exascale Earth System Model) component with PIO (Parallel IO) support,
  built with MVAPICH and UCX.\n\nTool homepage: https://github.com/NCAR/ParallelIO"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_pio_mvapich_4_0_ucx.out
