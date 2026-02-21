cwlVersion: v1.2
class: CommandLineTool
baseCommand: pytest
label: pytest-timeout
doc: "A pytest plugin to abort tests after a certain timeout. (Note: The provided
  text appears to be a container build error log rather than help text; no arguments
  could be extracted from the input.)\n\nTool homepage: https://github.com/pytest-dev/pytest-timeout"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pytest-timeout:1.0.0--py35_0
stdout: pytest-timeout.out
