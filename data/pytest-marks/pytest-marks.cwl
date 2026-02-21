cwlVersion: v1.2
class: CommandLineTool
baseCommand: pytest-marks
label: pytest-marks
doc: "The provided text appears to be a container build log rather than CLI help text.
  No tool description or arguments could be extracted from the input.\n\nTool homepage:
  https://github.com/TvoroG/pytest-lazy-fixture"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pytest-marks:0.4--py27_0
stdout: pytest-marks.out
