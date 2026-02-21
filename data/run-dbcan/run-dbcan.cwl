cwlVersion: v1.2
class: CommandLineTool
baseCommand: run-dbcan
label: run-dbcan
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system logs and a fatal error related to a container build
  process.\n\nTool homepage: https://github.com/linnabrown/run_dbcan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/run-dbcan:2.0.11--pyh3252c3a_0
stdout: run-dbcan.out
