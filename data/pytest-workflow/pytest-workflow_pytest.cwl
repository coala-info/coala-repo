cwlVersion: v1.2
class: CommandLineTool
baseCommand: pytest
label: pytest-workflow_pytest
doc: "A pytest plugin for testing workflow pipelines. (Note: The provided text is
  a container execution log and does not contain CLI help information; therefore,
  no arguments could be extracted.)\n\nTool homepage: https://github.com/LUMC/pytest-workflow"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pytest-workflow:1.2.0--py_0
stdout: pytest-workflow_pytest.out
