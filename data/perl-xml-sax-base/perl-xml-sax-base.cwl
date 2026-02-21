cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-xml-sax-base
label: perl-xml-sax-base
doc: "Base class for SAX drivers and filters. (Note: The provided text is an execution
  error log and does not contain help documentation or argument definitions.)\n\n
  Tool homepage: http://metacpan.org/pod/XML-SAX-Base"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-xml-sax-base:1.09--pl526_0
stdout: perl-xml-sax-base.out
