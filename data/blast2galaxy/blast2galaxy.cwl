cwlVersion: v1.2
class: CommandLineTool
baseCommand: blast2galaxy
label: blast2galaxy
doc: "The provided text contains system error messages related to container image
  extraction and disk space issues, rather than the tool's help documentation. No
  arguments or descriptions could be extracted from the input.\n\nTool homepage: https://github.com/IPK-BIT/blast2galaxy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blast2galaxy:1.0.0--pyhdfd78af_0
stdout: blast2galaxy.out
