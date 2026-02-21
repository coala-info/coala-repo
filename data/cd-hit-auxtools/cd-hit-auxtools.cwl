cwlVersion: v1.2
class: CommandLineTool
baseCommand: cd-hit-auxtools
label: cd-hit-auxtools
doc: "The provided text contains system error logs regarding a container build failure
  (no space left on device) and does not contain help documentation or usage instructions
  for the tool.\n\nTool homepage: https://github.com/weizhongli/cdhit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cd-hit-auxtools:4.8.1--h9948957_4
stdout: cd-hit-auxtools.out
