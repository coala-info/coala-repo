cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-xml-writer
label: perl-xml-writer
doc: "A Perl extension for writing XML documents. (Note: The provided text contains
  system error messages regarding container deployment and does not include functional
  CLI help documentation or argument definitions.)\n\nTool homepage: http://metacpan.org/pod/XML-Writer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-xml-writer:0.900--pl5321hdfd78af_0
stdout: perl-xml-writer.out
