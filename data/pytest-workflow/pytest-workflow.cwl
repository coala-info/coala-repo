cwlVersion: v1.2
class: CommandLineTool
baseCommand: pytest-workflow
label: pytest-workflow
doc: "The provided text does not contain help information or usage instructions; it
  appears to be a log of a failed container build or execution attempt.\n\nTool homepage:
  https://github.com/LUMC/pytest-workflow"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pytest-workflow:1.2.0--py_0
stdout: pytest-workflow.out
