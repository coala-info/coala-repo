cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_esmf_openmpi_4_1_6
label: esme_esmf_openmpi_4_1_6
doc: "Earth System Modeling Environment (ESME) with ESMF and OpenMPI. Note: The provided
  text contains container runtime error logs rather than tool help text, so no arguments
  could be identified.\n\nTool homepage: http://earthsystemmodeling.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_esmf_openmpi_4_1_6.out
