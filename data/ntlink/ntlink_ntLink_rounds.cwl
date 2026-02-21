cwlVersion: v1.2
class: CommandLineTool
baseCommand: ntLink_rounds
label: ntlink_ntLink_rounds
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system log messages and a fatal error regarding container
  image creation (no space left on device).\n\nTool homepage: https://github.com/bcgsc/ntLink"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ntlink:1.3.11--py312h7896c42_1
stdout: ntlink_ntLink_rounds.out
