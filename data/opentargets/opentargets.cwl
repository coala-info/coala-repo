cwlVersion: v1.2
class: CommandLineTool
baseCommand: opentargets
label: opentargets
doc: "Open Targets CLI tool (Note: The provided text is an error log regarding a container
  build failure and does not contain help documentation or argument definitions).\n
  \nTool homepage: https://github.com/opentargets/opentargets-py"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/opentargets:3.1.16--pyh864c0ab_1
stdout: opentargets.out
