cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_pio_psmpi_5_12_1
label: esme_pio_psmpi_5_12_1
doc: "The provided text does not contain help information for the tool, but appears
  to be a container runtime error log. No arguments could be extracted.\n\nTool homepage:
  https://github.com/NCAR/ParallelIO"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_pio_psmpi_5_12_1.out
