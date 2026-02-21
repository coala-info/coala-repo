cwlVersion: v1.2
class: CommandLineTool
baseCommand: opentargets-urlzsource
label: opentargets-urlzsource
doc: "A tool from the Open Targets project, likely used for handling compressed or
  remote data sources (urlzsource). Note: The provided help text contained only container
  runtime error messages and no usage information.\n\nTool homepage: https://github.com/opentargets/urlzsource"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/opentargets-urlzsource:1.0.0--pyh864c0ab_0
stdout: opentargets-urlzsource.out
