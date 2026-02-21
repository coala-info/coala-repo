cwlVersion: v1.2
class: CommandLineTool
baseCommand: muscle
label: muscle
doc: "Multiple sequence alignment software (Note: The provided help text contains
  only system error messages regarding container execution and does not list specific
  tool arguments).\n\nTool homepage: https://github.com/rcedgar/muscle"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/muscle:5.3--h9948957_3
stdout: muscle.out
