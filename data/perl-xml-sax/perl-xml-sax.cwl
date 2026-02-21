cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-xml-sax
label: perl-xml-sax
doc: "Perl XML SAX parser (Note: The provided text contains no help information as
  the executable was not found in the environment).\n\nTool homepage: http://metacpan.org/pod/XML::SAX"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-xml-sax:1.02--pl526_0
stdout: perl-xml-sax.out
