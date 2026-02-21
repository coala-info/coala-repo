cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_psmpi_5_10_0_esmf_info
label: esme_psmpi_5_10_0_esmf_info
doc: "The provided text does not contain help information for the tool; it consists
  of container runtime error logs regarding image conversion and disk space issues.\n
  \nTool homepage: https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_psmpi_5_10_0_esmf_info.out
