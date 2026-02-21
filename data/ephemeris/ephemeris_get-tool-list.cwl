cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - get-tool-list
label: ephemeris_get-tool-list
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log regarding container execution and disk space.\n\nTool homepage:
  https://github.com/galaxyproject/ephemeris"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ephemeris:0.10.11--pyhdfd78af_0
stdout: ephemeris_get-tool-list.out
