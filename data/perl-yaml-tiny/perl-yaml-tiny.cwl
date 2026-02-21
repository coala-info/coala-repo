cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-yaml-tiny
label: perl-yaml-tiny
doc: "The provided text does not contain help information or a description for the
  tool. It is an error log indicating that the executable 'perl-yaml-tiny' was not
  found in the system PATH.\n\nTool homepage: http://search.cpan.org/dist/YAML-Tiny/lib/YAML/Tiny.pm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-yaml-tiny:1.73--pl526_0
stdout: perl-yaml-tiny.out
