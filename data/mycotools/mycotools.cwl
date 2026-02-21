cwlVersion: v1.2
class: CommandLineTool
baseCommand: mycotools
label: mycotools
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding container execution (no space left
  on device).\n\nTool homepage: https://github.com/xonq/mycotools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mycotools:1.0.0--pyhdfd78af_0
stdout: mycotools.out
