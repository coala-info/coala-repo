cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_esmf_mpich_4_2_3
label: esme_esmf_mpich_4_2_3
doc: "The provided text does not contain help documentation for the tool. It contains
  system log messages and a fatal error regarding a container build failure due to
  insufficient disk space.\n\nTool homepage: http://earthsystemmodeling.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_esmf_mpich_4_2_3.out
