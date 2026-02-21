cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-xml-entities
label: perl-xml-entities
doc: "The provided text does not contain help information or usage instructions. It
  is an error log indicating that the executable 'perl-xml-entities' was not found
  in the system PATH.\n\nTool homepage: http://metacpan.org/pod/XML::Entities"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-xml-entities:1.0002--pl526_0
stdout: perl-xml-entities.out
