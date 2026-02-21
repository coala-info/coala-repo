cwlVersion: v1.2
class: CommandLineTool
baseCommand: mpiexec
label: esme_openmpi_5_0_6_mpiexec
doc: "MPI job execution tool (Note: The provided text contains error logs regarding
  container image conversion and disk space issues rather than command-line help documentation).\n
  \nTool homepage: https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_openmpi_5_0_6_mpiexec.out
