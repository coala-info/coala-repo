cwlVersion: v1.2
class: CommandLineTool
baseCommand: sequnwinder
label: sequnwinder
doc: "SeqUnwinder is a tool for characterizing multiple-condition transcription factor
  binding sites (Note: The provided text is a container build error log and does not
  contain help documentation).\n\nTool homepage: http://mahonylab.org/software/sequnwinder/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequnwinder:0.1.4--hdfd78af_1
stdout: sequnwinder.out
