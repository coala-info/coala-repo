cwlVersion: v1.2
class: CommandLineTool
baseCommand: ephemeris_check_galaxy_config
label: ephemeris_check_galaxy_config
doc: "A tool to check Galaxy configuration files. (Note: The provided help text contains
  only system error logs and no usage information; therefore, no arguments could be
  extracted.)\n\nTool homepage: https://github.com/galaxyproject/ephemeris"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ephemeris:0.10.11--pyhdfd78af_0
stdout: ephemeris_check_galaxy_config.out
