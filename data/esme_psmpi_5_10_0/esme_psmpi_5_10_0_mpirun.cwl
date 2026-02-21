cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_psmpi_5_10_0_mpirun
label: esme_psmpi_5_10_0_mpirun
doc: "The provided text contains error logs from a container runtime environment rather
  than the help documentation for the tool. As a result, no arguments or specific
  tool descriptions could be extracted.\n\nTool homepage: https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_psmpi_5_10_0_mpirun.out
