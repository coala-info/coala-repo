cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_pio_psmpi_5_10_0
label: esme_pio_psmpi_5_10_0
doc: "ESME (Energy Exascale Earth System Model) component with PIO and PSMPI support.
  Note: The provided text contains system error logs regarding container image conversion
  and disk space issues rather than command-line usage instructions.\n\nTool homepage:
  https://github.com/NCAR/ParallelIO"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_pio_psmpi_5_10_0.out
