cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-extutils-cbuilder
label: perl-extutils-cbuilder
doc: "The provided text does not contain help information or a description for the
  tool. It is an error log indicating that the executable was not found in the environment.\n
  \nTool homepage: http://search.cpan.org/dist/ExtUtils-CBuilder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-extutils-cbuilder:0.280230--pl5.22.0_0
stdout: perl-extutils-cbuilder.out
