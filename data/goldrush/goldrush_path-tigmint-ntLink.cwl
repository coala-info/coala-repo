cwlVersion: v1.2
class: CommandLineTool
baseCommand: goldrush_path-tigmint-ntLink
label: goldrush_path-tigmint-ntLink
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system log messages and a fatal error regarding container
  image building (no space left on device).\n\nTool homepage: https://github.com/bcgsc/goldrush"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/goldrush:1.2.2--py39h2de1943_0
stdout: goldrush_path-tigmint-ntLink.out
