cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_mpich_4_2_3_mpicc
label: esme_mpich_4_2_3_mpicc
doc: "MPI C compiler wrapper. (Note: The provided help text contains only container
  runtime error messages and does not list specific tool arguments.)\n\nTool homepage:
  https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_mpich_4_2_3_mpicc.out
