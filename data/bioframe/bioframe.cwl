cwlVersion: v1.2
class: CommandLineTool
baseCommand: bioframe
label: bioframe
doc: "The provided text does not contain help information or a description of the
  tool; it is a system error log indicating a 'no space left on device' failure during
  a container execution attempt.\n\nTool homepage: https://github.com/mirnylab/bioframe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioframe:0.8.0--pyhdfd78af_0
stdout: bioframe.out
