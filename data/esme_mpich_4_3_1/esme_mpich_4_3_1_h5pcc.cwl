cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_mpich_4_3_1_h5pcc
label: esme_mpich_4_3_1_h5pcc
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding container image building (no space
  left on device).\n\nTool homepage: https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_mpich_4_3_1_h5pcc.out
