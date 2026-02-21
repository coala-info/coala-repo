cwlVersion: v1.2
class: CommandLineTool
baseCommand: ephemeris
label: ephemeris
doc: "The provided text contains error logs and environment information rather than
  tool help text. Ephemeris is a tool for managing Galaxy instances, but no specific
  arguments or descriptions could be extracted from this input.\n\nTool homepage:
  https://github.com/galaxyproject/ephemeris"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ephemeris:0.10.11--pyhdfd78af_0
stdout: ephemeris.out
