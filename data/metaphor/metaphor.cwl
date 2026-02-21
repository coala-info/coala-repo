cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaphor
label: metaphor
doc: "Metaphor is a tool for metabolic modeling and analysis (Note: The provided text
  contains system error logs rather than help documentation).\n\nTool homepage: https://github.com/vinisalazar/metaphor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaphor:1.7.14--pyhdfd78af_0
stdout: metaphor.out
