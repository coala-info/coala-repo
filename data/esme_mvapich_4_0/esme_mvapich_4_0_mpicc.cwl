cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_mvapich_4_0_mpicc
label: esme_mvapich_4_0_mpicc
doc: "MPI C compiler wrapper (Note: The provided text is an error log from a container
  runtime and does not contain usage instructions or argument definitions).\n\nTool
  homepage: https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_mvapich_4_0_mpicc.out
