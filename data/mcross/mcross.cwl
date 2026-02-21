cwlVersion: v1.2
class: CommandLineTool
baseCommand: mcross
label: mcross
doc: "Mass spectrometry cross-linking analysis tool (Note: The provided text contains
  container runtime error logs rather than help documentation, so no arguments could
  be extracted).\n\nTool homepage: https://github.com/huijfeng/mCross"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mcross:0.9.5--hdfd78af_0
stdout: mcross.out
