cwlVersion: v1.2
class: CommandLineTool
baseCommand: esmf_info
label: esme_mvapich_4_0_ofi_esmf_info
doc: "A tool to display information about the Earth System Modeling Framework (ESMF)
  installation, including version, compiler settings, and library paths.\n\nTool homepage:
  https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_mvapich_4_0_ofi_esmf_info.out
