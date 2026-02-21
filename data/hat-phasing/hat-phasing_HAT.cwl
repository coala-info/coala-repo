cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hat-phasing
  - HAT
label: hat-phasing_HAT
doc: "The provided text is an error log indicating a system failure (no space left
  on device) during container image conversion and does not contain the tool's help
  documentation or argument definitions.\n\nTool homepage: https://github.com/AbeelLab/hat/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hat-phasing:0.1.8--pyh5e36f6f_0
stdout: hat-phasing_HAT.out
