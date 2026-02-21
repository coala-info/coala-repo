cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_esmf_mvapich_4_0
label: esme_esmf_mvapich_4_0
doc: "Earth System Modeling Environment (ESME) component using ESMF and MVAPICH.\n
  \nTool homepage: http://earthsystemmodeling.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_esmf_mvapich_4_0.out
