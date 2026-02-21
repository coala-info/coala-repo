cwlVersion: v1.2
class: CommandLineTool
baseCommand: pytest
label: pytest-mock
doc: "A pytest plugin that provides a mocker fixture which is a thin-wrapper around
  the patching API provided by the mock package.\n\nTool homepage: https://github.com/pytest-dev/pytest-mock"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pytest-mock:1.1--py35_0
stdout: pytest-mock.out
