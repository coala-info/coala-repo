cwlVersion: v1.2
class: CommandLineTool
baseCommand: hapflk_hapviterbi
label: hapflk_hapviterbi
doc: "HapFLK hapviterbi tool (Note: The provided input text contains container runtime
  error logs rather than tool help documentation; therefore, no arguments could be
  extracted.)\n\nTool homepage: https://github.com/BertrandServin/hapflk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hapflk:1.3.0--py27_0
stdout: hapflk_hapviterbi.out
