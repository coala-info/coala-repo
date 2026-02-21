cwlVersion: v1.2
class: CommandLineTool
baseCommand: memote
label: memote
doc: "The provided text is a container execution error log and does not contain help
  information or argument definitions for the 'memote' tool.\n\nTool homepage: https://memote.readthedocs.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/memote:0.17.0--pyhdfd78af_0
stdout: memote.out
