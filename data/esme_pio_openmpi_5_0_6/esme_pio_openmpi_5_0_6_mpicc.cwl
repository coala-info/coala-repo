cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_pio_openmpi_5_0_6_mpicc
label: esme_pio_openmpi_5_0_6_mpicc
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build a SIF image due to insufficient disk space, rather
  than CLI help text. No arguments or tool descriptions could be extracted.\n\nTool
  homepage: https://github.com/NCAR/ParallelIO"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_pio_openmpi_5_0_6_mpicc.out
