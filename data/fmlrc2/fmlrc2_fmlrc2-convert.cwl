cwlVersion: v1.2
class: CommandLineTool
baseCommand: fmlrc2-convert
label: fmlrc2_fmlrc2-convert
doc: "The provided text does not contain help information or a description of the
  tool; it appears to be a container runtime error log. Based on the tool name, this
  utility is typically used for converting BWT formats in the FMLRC2 suite.\n\nTool
  homepage: https://github.com/HudsonAlpha/rust-fmlrc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fmlrc2:0.1.8--h7f95895_0
stdout: fmlrc2_fmlrc2-convert.out
