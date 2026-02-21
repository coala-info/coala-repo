cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncrf
label: ncrf
doc: "Noise-Cancelling Repeat Finder (Note: The provided text is a system error message
  and does not contain help documentation or argument definitions).\n\nTool homepage:
  https://github.com/makovalab-psu/NoiseCancellingRepeatFinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncrf:1.01.02--h7b50bb2_6
stdout: ncrf.out
