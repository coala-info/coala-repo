cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fmsi
  - export
label: fmsi_export
doc: "Export data from an FMS index.\n\nTool homepage: https://github.com/OndrejSladky/fmsi"
inputs:
  - id: index_prefix
    type: File
    secondaryFiles:
      - .fmsi.ac
      - .fmsi.ac_gt
      - .fmsi.gt
      - .fmsi.mask
      - .fmsi.misc
      - .fmsi.klcp?
    doc: Prefix of the FMS index files to export from.
    inputBinding:
      position: 200
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fmsi:0.4.0--h077b44d_0
stdout: fmsi_export.out
