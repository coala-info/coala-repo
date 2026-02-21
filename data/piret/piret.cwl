cwlVersion: v1.2
class: CommandLineTool
baseCommand: piret
label: piret
doc: "PiReT (Pipeline for RNA-Seq Transcription). Note: The provided input text is
  a system error log regarding a container build failure ('no space left on device')
  and does not contain the tool's help documentation or argument definitions.\n\n
  Tool homepage: https://github.com/mshakya/PyPiReT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/piret:0.3.4--r44hdfd78af_3
stdout: piret.out
