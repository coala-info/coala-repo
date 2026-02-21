cwlVersion: v1.2
class: CommandLineTool
baseCommand: scrubby
label: scrubby
doc: "The provided text is a system error log regarding a container build failure
  ('no space left on device') and does not contain the help documentation or usage
  instructions for the 'scrubby' tool.\n\nTool homepage: https://github.com/esteinig/scrubby"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scrubby:0.2.1--h715e4b3_0
stdout: scrubby.out
