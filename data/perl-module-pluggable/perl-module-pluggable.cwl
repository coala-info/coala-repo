cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-module-pluggable
label: perl-module-pluggable
doc: "The provided text does not contain help information or a description for the
  tool; it is an error log indicating the executable was not found.\n\nTool homepage:
  http://metacpan.org/pod/Module::Pluggable"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-module-pluggable:5.2--pl526_0
stdout: perl-module-pluggable.out
