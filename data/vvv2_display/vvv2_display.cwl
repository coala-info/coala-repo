cwlVersion: v1.2
class: CommandLineTool
baseCommand: vvv2_display
label: vvv2_display
doc: "The provided text does not contain help information or a description of the
  tool's functionality; it is an error log from a container build process.\n\nTool
  homepage: https://github.com/ANSES_Ploufragan/vvv2_display/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vvv2_display:0.2.5.0--pyhdfd78af_0
stdout: vvv2_display.out
