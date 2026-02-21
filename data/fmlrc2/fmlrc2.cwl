cwlVersion: v1.2
class: CommandLineTool
baseCommand: fmlrc2
label: fmlrc2
doc: "FMLRC2: FM-index Long Read Corrector 2 (Note: The provided help text contains
  only system error messages and no usage information or arguments to parse).\n\n
  Tool homepage: https://github.com/HudsonAlpha/rust-fmlrc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fmlrc2:0.1.8--h7f95895_0
stdout: fmlrc2.out
