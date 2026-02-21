cwlVersion: v1.2
class: CommandLineTool
baseCommand: pispino_createreadpairslist
label: pispino_pispino_createreadpairslist
doc: "The provided help text does not contain usage information or a description of
  the tool's functionality due to a system error (no space left on device) during
  the container execution.\n\nTool homepage: https://github.com/hsgweon/pispino"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pispino:1.1--py35_0
stdout: pispino_pispino_createreadpairslist.out
