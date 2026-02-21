cwlVersion: v1.2
class: CommandLineTool
baseCommand: liv_utils
label: liv_utils
doc: "The provided text does not contain help information or a description of the
  tool; it contains system log messages and a fatal error regarding container image
  conversion and disk space.\n\nTool homepage: https://github.com/neilswainston/liv-utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/livekraken:1.0--pl5321h9948957_12
stdout: liv_utils.out
