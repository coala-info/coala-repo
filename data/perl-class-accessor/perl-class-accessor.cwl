cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-class-accessor
label: perl-class-accessor
doc: "The provided text does not contain help information or a description for the
  tool; it is an error log indicating that the executable was not found in the environment.\n
  \nTool homepage: http://metacpan.org/pod/Class::Accessor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-class-accessor:0.51--pl526_0
stdout: perl-class-accessor.out
