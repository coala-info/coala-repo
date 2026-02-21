cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_esmf_mvapich_4_0_ofi
label: esme_esmf_mvapich_4_0_ofi
doc: "Earth System Modeling Framework (ESMF) tool. (Note: The provided text contains
  container runtime error logs and does not list specific command-line arguments or
  usage instructions).\n\nTool homepage: http://earthsystemmodeling.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_esmf_mvapich_4_0_ofi.out
