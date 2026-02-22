cwlVersion: v1.2
class: CommandLineTool
baseCommand: comet
label: comet-ms_comet
doc: "Comet is an open source tandem mass spectrometry (MS/MS) sequence database search
  tool. Note: The provided help text contains only system error messages regarding
  container execution and does not list specific command-line arguments.\n\nTool homepage:
  http://comet-ms.sourceforge.net/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/comet-ms:2024011--hb319eff_0
stdout: comet-ms_comet.out
