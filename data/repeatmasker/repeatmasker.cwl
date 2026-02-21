cwlVersion: v1.2
class: CommandLineTool
baseCommand: RepeatMasker
label: repeatmasker
doc: "The provided text does not contain help information for RepeatMasker; it contains
  container runtime error logs. No arguments could be extracted.\n\nTool homepage:
  https://www.repeatmasker.org/RepeatMasker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/repeatmasker:4.2.2--pl5321hdfd78af_0
stdout: repeatmasker.out
