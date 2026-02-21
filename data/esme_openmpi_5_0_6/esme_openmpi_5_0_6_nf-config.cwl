cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_openmpi_5_0_6_nf-config
label: esme_openmpi_5_0_6_nf-config
doc: "Configuration tool for esme_openmpi_5_0_6_nf (Note: The provided text contains
  only system error logs and no usage information).\n\nTool homepage: https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_openmpi_5_0_6_nf-config.out
