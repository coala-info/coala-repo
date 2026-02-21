cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-xml
label: perl-test-xml
doc: "The provided text does not contain help documentation as the executable was
  not found in the environment. perl-test-xml is typically a Perl module (Test::XML)
  used for testing XML data.\n\nTool homepage: https://github.com/zszszszsz/.config"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-xml:0.08--pl526_1
stdout: perl-test-xml.out
