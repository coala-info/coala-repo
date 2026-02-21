cwlVersion: v1.2
class: CommandLineTool
baseCommand: minorseq
label: minorseq
doc: "Minor variant detection from NGS data (Note: The provided text is a system error
  message and does not contain usage instructions or argument definitions).\n\nTool
  homepage: https://github.com/PacificBiosciences/minorseq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minorseq:1.12.0--0
stdout: minorseq.out
