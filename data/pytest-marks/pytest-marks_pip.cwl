cwlVersion: v1.2
class: CommandLineTool
baseCommand: pytest
label: pytest-marks_pip
doc: "A pytest plugin for handling marks (Note: The provided text appears to be a
  container build log rather than help text; no arguments could be extracted from
  the input).\n\nTool homepage: https://github.com/TvoroG/pytest-lazy-fixture"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pytest-marks:0.4--py27_0
stdout: pytest-marks_pip.out
