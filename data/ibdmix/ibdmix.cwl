cwlVersion: v1.2
class: CommandLineTool
baseCommand: ibdmix
label: ibdmix
doc: "The provided text is a system error message indicating a failure to build the
  container image due to insufficient disk space; it does not contain tool help information
  or argument definitions.\n\nTool homepage: https://github.com/PrincetonUniversity/IBDmix"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibdmix:1.0.1--h4ac6f70_2
stdout: ibdmix.out
