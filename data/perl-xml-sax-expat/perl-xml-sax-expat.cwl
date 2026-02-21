cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-xml-sax-expat
label: perl-xml-sax-expat
doc: "The provided text does not contain help information as the executable was not
  found in the environment. perl-xml-sax-expat is typically a Perl module (XML::SAX::Expat)
  providing a SAX2 interface to the Expat XML parser.\n\nTool homepage: https://github.com/pld-linux/perl-XML-SAX-ExpatNB"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-xml-sax-expat:0.51--pl526_2
stdout: perl-xml-sax-expat.out
