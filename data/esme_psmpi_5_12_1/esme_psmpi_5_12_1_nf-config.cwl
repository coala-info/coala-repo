cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_psmpi_5_12_1_nf-config
label: esme_psmpi_5_12_1_nf-config
doc: "A configuration tool for the ESME (Earth System Model Environment) software
  stack, specifically for the PSMPI 5.12.1 build environment.\n\nTool homepage: https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_psmpi_5_12_1_nf-config.out
