cwlVersion: v1.2
class: CommandLineTool
baseCommand: pytest
label: pytest-workflow_pytest
doc: "pytest: a plugin for pytest to manage workflows\n\nTool homepage: https://github.com/LUMC/pytest-workflow"
inputs:
  - id: basetemp
    type: Directory
    doc: Base directory for temporary files, not in pytest's current working 
      directory.
    inputBinding:
      position: 101
      prefix: --basetemp
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pytest-workflow:1.2.0--py_0
stdout: pytest-workflow_pytest.out
