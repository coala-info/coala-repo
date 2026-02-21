cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-xml-parser-lite
label: perl-xml-parser-lite
doc: "A lightweight XML parser (Note: The provided text is an error log indicating
  the executable was not found, so no specific arguments could be parsed from the
  help text).\n\nTool homepage: http://metacpan.org/pod/XML-Parser-Lite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-xml-parser-lite:0.722--pl526_0
stdout: perl-xml-parser-lite.out
