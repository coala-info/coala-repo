cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_mpich_4_2_3_nf-config
label: esme_mpich_4_2_3_nf-config
doc: "A configuration tool for ESME (Earth System Model) with MPICH support. Note:
  The provided text appears to be a container runtime error log rather than standard
  help text, so no arguments could be extracted.\n\nTool homepage: https://github.com/j34ni/bioconda-recipes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_mpich_4_2_3_nf-config.out
