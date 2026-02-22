cwlVersion: v1.2
class: CommandLineTool
baseCommand: ampliconsuite
label: ampliconsuite
doc: "AmpliconSuite (Note: The provided text is a system error log regarding a container
  build failure and does not contain CLI help information or argument definitions).\n\
  \nTool homepage: https://github.com/AmpliconSuite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ampliconsuite:1.5.0--pyhdfd78af_0
stdout: ampliconsuite.out
