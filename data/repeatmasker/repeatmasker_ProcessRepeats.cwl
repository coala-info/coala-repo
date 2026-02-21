cwlVersion: v1.2
class: CommandLineTool
baseCommand: ProcessRepeats
label: repeatmasker_ProcessRepeats
doc: "The provided text does not contain help information for the tool, but appears
  to be a container runtime error log. No arguments could be extracted.\n\nTool homepage:
  https://www.repeatmasker.org/RepeatMasker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/repeatmasker:4.2.2--pl5321hdfd78af_0
stdout: repeatmasker_ProcessRepeats.out
