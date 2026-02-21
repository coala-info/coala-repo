cwlVersion: v1.2
class: CommandLineTool
baseCommand: CLARK-l
label: clark_CLARK-l
doc: "The provided text is an error log regarding a container build failure (no space
  left on device) and does not contain the help text or usage information for the
  tool.\n\nTool homepage: https://github.com/rouni001/CLARK"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clark:1.3.0.0--h9948957_0
stdout: clark_CLARK-l.out
