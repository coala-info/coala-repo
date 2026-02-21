cwlVersion: v1.2
class: CommandLineTool
baseCommand: mpirun
label: esme_mpich_4_2_3_mpirun
doc: "MPI run command for ESME (Note: The provided text contains error logs regarding
  container image conversion and disk space issues rather than standard CLI help documentation).\n
  \nTool homepage: https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_mpich_4_2_3_mpirun.out
