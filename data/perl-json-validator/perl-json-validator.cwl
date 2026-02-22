cwlVersion: v1.2
class: CommandLineTool
baseCommand: json-validator
label: perl-json-validator
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a Singularity/Docker container execution failure
  ('no space left on device').\n\nTool homepage: https://github.com/jhthorsen/json-validator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-json-validator:5.15--pl5321hdfd78af_0
stdout: perl-json-validator.out
