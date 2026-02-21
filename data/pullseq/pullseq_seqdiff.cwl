cwlVersion: v1.2
class: CommandLineTool
baseCommand: pullseq_seqdiff
label: pullseq_seqdiff
doc: "The provided text does not contain help information for the tool; it contains
  container runtime error messages regarding a failed image build.\n\nTool homepage:
  https://github.com/bcthomas/pullseq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pullseq:1.0.2--h1104d80_11
stdout: pullseq_seqdiff.out
