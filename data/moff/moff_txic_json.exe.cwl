cwlVersion: v1.2
class: CommandLineTool
baseCommand: moff_txic_json.exe
label: moff_txic_json.exe
doc: "A tool associated with the moFF (modest Feature Finder) suite, likely used for
  processing LC-MS data in JSON format. Note: The provided input text contained system
  error logs rather than usage instructions, so no arguments could be extracted.\n
  \nTool homepage: https://github.com/compomics/moFF"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moff:2.0.3--py36_2
stdout: moff_txic_json.exe.out
