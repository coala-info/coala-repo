cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-xml-simple
label: perl-xml-simple
doc: "The provided text is an error log indicating that the executable 'perl-xml-simple'
  was not found; no help text or usage information was available to parse arguments.\n
  \nTool homepage: http://metacpan.org/pod/XML-Simple"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-xml-simple:2.25--pl526_0
stdout: perl-xml-simple.out
