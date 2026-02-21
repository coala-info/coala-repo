cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_pio_mvapich_4_0_ofi
label: esme_pio_mvapich_4_0_ofi
doc: "The provided text does not contain help information or a description for the
  tool; it contains system log messages and a fatal error regarding container image
  creation due to insufficient disk space.\n\nTool homepage: https://github.com/NCAR/ParallelIO"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_pio_mvapich_4_0_ofi.out
