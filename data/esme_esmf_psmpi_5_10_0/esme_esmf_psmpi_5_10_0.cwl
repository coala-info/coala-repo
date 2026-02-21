cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_esmf_psmpi_5_10_0
label: esme_esmf_psmpi_5_10_0
doc: "Earth System Modeling Environment (ESME) with ESMF and PSMPI support. (Note:
  The provided text contains container runtime error logs rather than tool help documentation;
  therefore, no arguments could be extracted.)\n\nTool homepage: http://earthsystemmodeling.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_esmf_psmpi_5_10_0.out
