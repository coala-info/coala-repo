cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_esmf_openmpi_5_0_6
label: esme_esmf_openmpi_5_0_6
doc: "Earth System Modeling Environment (ESME) component with ESMF and OpenMPI support.
  (Note: The provided help text contains only system error logs and no usage information.)\n
  \nTool homepage: http://earthsystemmodeling.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_esmf_openmpi_5_0_6.out
