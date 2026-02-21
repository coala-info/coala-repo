cwlVersion: v1.2
class: CommandLineTool
baseCommand: sequnwinder
label: sequnwinder_sequnwinder.jar
doc: "SeqUnwinder (Note: The provided text is a system error log regarding a container
  build failure and does not contain tool help information or argument definitions.)\n
  \nTool homepage: http://mahonylab.org/software/sequnwinder/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequnwinder:0.1.4--hdfd78af_1
stdout: sequnwinder_sequnwinder.jar.out
