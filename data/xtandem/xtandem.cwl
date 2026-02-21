cwlVersion: v1.2
class: CommandLineTool
baseCommand: xtandem
label: xtandem
doc: "X! Tandem is a software for identifying proteins from tandem mass spectrometry
  data. (Note: The provided text contains container build logs and error messages
  rather than command-line help documentation; therefore, no arguments could be extracted.)\n
  \nTool homepage: https://github.com/bspratt/xtandem-g"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xtandem:15.12.15.2--h4464bbb_11
stdout: xtandem.out
