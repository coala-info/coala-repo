cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_mpich_4_2_3_h5cc
label: esme_mpich_4_2_3_h5cc
doc: "HDF5 C compiler wrapper for ESME with MPICH support. (Note: The provided text
  is an error log indicating a container runtime failure and does not contain usage
  instructions or argument definitions).\n\nTool homepage: https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_mpich_4_2_3_h5cc.out
