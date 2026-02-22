cwlVersion: v1.2
class: CommandLineTool
baseCommand: json_xs
label: perl-json-xs
doc: "A command-line tool for converting to and from JSON format using the Perl JSON::XS
  module. (Note: The provided text contained only system error messages and no usage
  information; arguments could not be extracted from the input text.)\n\nTool homepage:
  https://metacpan.org/pod/JSON::XS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-json-xs:4.04--pl5321h9948957_0
stdout: perl-json-xs.out
