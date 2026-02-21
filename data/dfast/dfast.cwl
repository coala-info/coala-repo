cwlVersion: v1.2
class: CommandLineTool
baseCommand: dfast
label: dfast
doc: "DDBJ Fast Annotation and Submission Tool. (Note: The provided text is a container
  runtime error log and does not contain help documentation or argument definitions.)\n
  \nTool homepage: https://dfast.nig.ac.jp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dfast:1.3.7--h5ca1c30_0
stdout: dfast.out
