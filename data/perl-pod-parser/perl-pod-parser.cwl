cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-pod-parser
label: perl-pod-parser
doc: "The provided text does not contain help information as the executable was not
  found in the environment. No arguments could be parsed.\n\nTool homepage: https://github.com/jjatria/perl6-Pod-Parser"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-pod-parser:1.63--pl5.22.0_0
stdout: perl-pod-parser.out
