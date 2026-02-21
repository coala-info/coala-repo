cwlVersion: v1.2
class: CommandLineTool
baseCommand: airr
label: airr_airr-tools
doc: "The provided text is a container execution error log and does not contain help
  documentation or usage instructions for the tool. As a result, no arguments could
  be extracted.\n\nTool homepage: http://docs.airr-community.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/airr:1.5.1--pyh7cba7a3_0
stdout: airr_airr-tools.out
