cwlVersion: v1.2
class: CommandLineTool
baseCommand: esme_esmf_psmpi_5_12_1
label: esme_esmf_psmpi_5_12_1
doc: "A tool related to the Earth System Modeling Framework (ESMF) and ESME, utilizing
  PSMPI.\n\nTool homepage: http://earthsystemmodeling.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_esmf_psmpi_5_12_1.out
