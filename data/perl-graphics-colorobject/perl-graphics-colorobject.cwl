cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-graphics-colorobject
label: perl-graphics-colorobject
doc: "The tool 'perl-graphics-colorobject' could not be executed, and no help text
  was available to parse. The provided text indicates a fatal error where the executable
  was not found in the system PATH.\n\nTool homepage: http://metacpan.org/pod/Graphics::ColorObject"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-graphics-colorobject:0.5.0--pl526_1
stdout: perl-graphics-colorobject.out
