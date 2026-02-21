cwlVersion: v1.2
class: CommandLineTool
baseCommand: repeatmodeler
label: repeatmodeler
doc: "The provided text does not contain help information or a description of the
  tool; it contains container runtime logs and a fatal error message.\n\nTool homepage:
  https://www.repeatmasker.org/RepeatModeler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/repeatmodeler:2.0.7--pl5321hdfd78af_0
stdout: repeatmodeler.out
