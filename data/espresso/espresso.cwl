cwlVersion: v1.2
class: CommandLineTool
baseCommand: espresso
label: espresso
doc: "The provided text does not contain help information or a description of the
  tool; it contains system log messages and a fatal error regarding container image
  creation (no space left on device).\n\nTool homepage: https://github.com/Xinglab/espresso"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/espresso:1.6.0--pl5321h5ca1c30_1
stdout: espresso.out
