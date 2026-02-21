cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-xml-parser
label: perl-xml-parser
doc: "A Perl module for parsing XML documents. (Note: The provided text contains a
  fatal error indicating the executable was not found, so no specific arguments or
  usage details could be extracted from the input.)\n\nTool homepage: https://github.com/zszszszsz/.config"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-xml-parser:2.44--pl5.22.0_0
stdout: perl-xml-parser.out
