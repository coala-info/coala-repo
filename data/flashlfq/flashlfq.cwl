cwlVersion: v1.2
class: CommandLineTool
baseCommand: flashlfq
label: flashlfq
doc: "FlashLFQ is a tool for label-free quantification of mass spectrometry data.
  (Note: The provided help text contains only container build logs and error messages,
  and does not list specific command-line arguments.)\n\nTool homepage: https://github.com/smith-chem-wisc/FlashLFQ"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flashlfq:2.1.4--hdfd78af_0
stdout: flashlfq.out
