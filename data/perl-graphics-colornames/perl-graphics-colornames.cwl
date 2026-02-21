cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-graphics-colornames
label: perl-graphics-colornames
doc: "The provided text does not contain help information as the executable was not
  found in the environment. No arguments could be parsed.\n\nTool homepage: http://metacpan.org/pod/Graphics::ColorNames"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-graphics-colornames:2.11--pl526_0
stdout: perl-graphics-colornames.out
