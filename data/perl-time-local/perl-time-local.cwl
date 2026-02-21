cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-time-local
label: perl-time-local
doc: "The provided text does not contain help information. It is a log of a failed
  execution attempt where the executable 'perl-time-local' was not found in the system
  PATH.\n\nTool homepage: https://github.com/zszszszsz/.config"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-time-local:1.2300--pl5.22.0_0
stdout: perl-time-local.out
