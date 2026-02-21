cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-xml-twig
label: perl-xml-twig
doc: "The provided text does not contain help information as the executable was not
  found in the environment.\n\nTool homepage: http://metacpan.org/pod/XML-Twig"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-xml-twig:3.52--pl526_1
stdout: perl-xml-twig.out
