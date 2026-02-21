cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - workflow-to-tool
label: ephemeris_workflow-to-tool
doc: "A tool within the ephemeris suite, likely used for converting Galaxy workflows
  into tool definitions. Note: The provided text contains only system error logs and
  no usage information or argument definitions.\n\nTool homepage: https://github.com/galaxyproject/ephemeris"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ephemeris:0.10.11--pyhdfd78af_0
stdout: ephemeris_workflow-to-tool.out
