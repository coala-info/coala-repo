cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_mpich_4_2_3
label: esme_mpich_4_2_3
doc: "The provided text does not contain help information or usage instructions. It
  consists of system log messages and a fatal error regarding container image creation
  (no space left on device).\n\nTool homepage: https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_mpich_4_2_3.out
