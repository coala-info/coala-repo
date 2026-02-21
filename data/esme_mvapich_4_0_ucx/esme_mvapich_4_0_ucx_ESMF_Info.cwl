cwlVersion: v1.2
class: CommandLineTool
baseCommand: ESMF_Info
label: esme_mvapich_4_0_ucx_ESMF_Info
doc: "A tool to display information about the Earth System Modeling Framework (ESMF)
  installation. Note: The provided text contains container environment logs and a
  fatal error regarding disk space rather than standard help documentation.\n\nTool
  homepage: https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_mvapich_4_0_ucx_ESMF_Info.out
