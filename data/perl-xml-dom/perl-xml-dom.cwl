cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-xml-dom
label: perl-xml-dom
doc: "A Perl module for building and manipulating XML DOM trees. (Note: The provided
  text is a container build error log and does not contain CLI help information or
  argument definitions.)\n\nTool homepage: http://metacpan.org/pod/XML-DOM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-xml-dom:1.46--pl526_0
stdout: perl-xml-dom.out
