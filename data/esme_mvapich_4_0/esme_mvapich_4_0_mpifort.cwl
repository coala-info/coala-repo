cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_mvapich_4_0_mpifort
label: esme_mvapich_4_0_mpifort
doc: "The provided text does not contain help information or a description of the
  tool's functionality; it contains container runtime error messages.\n\nTool homepage:
  https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_mvapich_4_0_mpifort.out
