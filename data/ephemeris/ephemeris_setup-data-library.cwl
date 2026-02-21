cwlVersion: v1.2
class: CommandLineTool
baseCommand: setup-data-library
label: ephemeris_setup-data-library
doc: "A tool from the Ephemeris suite to setup data libraries in Galaxy. (Note: The
  provided help text contains only system error logs and no usage information.)\n\n
  Tool homepage: https://github.com/galaxyproject/ephemeris"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ephemeris:0.10.11--pyhdfd78af_0
stdout: ephemeris_setup-data-library.out
