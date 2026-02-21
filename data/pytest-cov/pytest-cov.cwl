cwlVersion: v1.2
class: CommandLineTool
baseCommand: pytest
label: pytest-cov
doc: "A pytest plugin for measuring coverage. Note: The provided text appears to be
  a container build error log rather than CLI help text, so no arguments could be
  extracted.\n\nTool homepage: https://github.com/pytest-dev/pytest-cov"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pytest-cov:2.4.0--py34_0
stdout: pytest-cov.out
