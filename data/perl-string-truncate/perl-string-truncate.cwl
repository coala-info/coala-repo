cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-string-truncate
label: perl-string-truncate
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of system error messages related to a failed Singularity/Docker
  container execution due to insufficient disk space.\n\nTool homepage: https://github.com/rjbs/String-Truncate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-string-truncate:1.100603--pl5321hdfd78af_0
stdout: perl-string-truncate.out
