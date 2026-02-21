cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_psmpi_5_12_1_mpicc
label: esme_psmpi_5_12_1_mpicc
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system error logs related to an Apptainer/Singularity container
  build failure (no space left on device).\n\nTool homepage: https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_psmpi_5_12_1_mpicc.out
