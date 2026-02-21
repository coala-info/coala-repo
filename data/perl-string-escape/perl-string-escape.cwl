cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-string-escape
label: perl-string-escape
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating that the executable was not found in the environment.\n\nTool homepage:
  http://metacpan.org/pod/String::Escape"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-string-escape:2010.002--pl526_0
stdout: perl-string-escape.out
