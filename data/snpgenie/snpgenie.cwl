cwlVersion: v1.2
class: CommandLineTool
baseCommand: snpgenie
label: snpgenie
doc: "SNPGenie (Note: The provided text is a container build error log and does not
  contain help information or usage instructions.)\n\nTool homepage: https://github.com/chasewnelson/SNPGenie"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snpgenie:1.0--hdfd78af_1
stdout: snpgenie.out
