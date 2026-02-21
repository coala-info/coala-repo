cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-config-simple
label: perl-config-simple
doc: "The provided text does not contain help information for the tool; it is an error
  log indicating that the executable 'perl-config-simple' was not found in the system
  PATH.\n\nTool homepage: https://github.com/zszszszsz/.config"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-config-simple:4.58--pl5.22.0_0
stdout: perl-config-simple.out
