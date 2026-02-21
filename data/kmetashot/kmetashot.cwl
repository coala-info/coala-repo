cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmetashot
label: kmetashot
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log indicating a failure to build a container image due to
  insufficient disk space.\n\nTool homepage: https://github.com/gdefazio/kMetaShot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmetashot:2.0--pyh7e72e81_1
stdout: kmetashot.out
