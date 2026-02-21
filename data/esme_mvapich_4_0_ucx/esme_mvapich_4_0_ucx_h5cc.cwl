cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_mvapich_4_0_ucx_h5cc
label: esme_mvapich_4_0_ucx_h5cc
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a container image build failure (no space
  left on device).\n\nTool homepage: https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_mvapich_4_0_ucx_h5cc.out
