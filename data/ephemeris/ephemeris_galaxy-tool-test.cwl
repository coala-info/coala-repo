cwlVersion: v1.2
class: CommandLineTool
baseCommand: galaxy-tool-test
label: ephemeris_galaxy-tool-test
doc: "A tool from the Ephemeris suite for testing Galaxy tools. (Note: The provided
  text contains system error logs rather than help documentation, so no arguments
  could be extracted.)\n\nTool homepage: https://github.com/galaxyproject/ephemeris"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ephemeris:0.10.11--pyhdfd78af_0
stdout: ephemeris_galaxy-tool-test.out
