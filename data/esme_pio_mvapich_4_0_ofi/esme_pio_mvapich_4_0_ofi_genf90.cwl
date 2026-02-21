cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_pio_mvapich_4_0_ofi_genf90
label: esme_pio_mvapich_4_0_ofi_genf90
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to build a SIF image due to insufficient disk space.\n\nTool homepage: https://github.com/NCAR/ParallelIO"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_pio_mvapich_4_0_ofi_genf90.out
