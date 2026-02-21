cwlVersion: v1.2
class: CommandLineTool
baseCommand: hichipper
label: hichipper
doc: "A package for HiChIP data processing. (Note: The provided help text contains
  only system error messages regarding container execution and does not list specific
  command-line arguments.)\n\nTool homepage: https://github.com/aryeelab/hichipper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hichipper:0.7.7--py_0
stdout: hichipper.out
