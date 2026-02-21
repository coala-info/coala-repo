cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnasketch_design-thermoswitch.py
label: rnasketch_design-thermoswitch.py
doc: "A tool for designing RNA thermoswitches using RNAsketch. Note: The provided
  input text contained system logs and a fatal error rather than help documentation,
  so no arguments could be extracted.\n\nTool homepage: https://github.com/ViennaRNA/RNAsketch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnasketch:1.5--py27_1
stdout: rnasketch_design-thermoswitch.py.out
