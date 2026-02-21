cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-text-template-simple
label: perl-text-template-simple
doc: "The provided text does not contain help information as the executable was not
  found in the environment.\n\nTool homepage: http://metacpan.org/pod/Text::Template::Simple"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-text-template-simple:0.91--pl526_0
stdout: perl-text-template-simple.out
