cwlVersion: v1.2
class: CommandLineTool
baseCommand: mpicxx
label: esme_mvapich_4_0_ucx_mpicxx
doc: "MPI C++ compiler wrapper (ESME build with MVAPICH and UCX support)\n\nTool homepage:
  https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_mvapich_4_0_ucx_mpicxx.out
