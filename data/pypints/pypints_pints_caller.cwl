cwlVersion: v1.2
class: CommandLineTool
baseCommand: pints_caller
label: pypints_pints_caller
doc: "Peak Identification from Nascent Transcription Data (Note: The provided text
  contains container build logs rather than tool help text; no arguments could be
  extracted from the input).\n\nTool homepage: https://pints.yulab.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypints:1.2.1--pyh7e72e81_0
stdout: pypints_pints_caller.out
