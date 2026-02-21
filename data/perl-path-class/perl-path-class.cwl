cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-path-class
label: perl-path-class
doc: "The provided text does not contain help information as the executable was not
  found in the environment. perl-path-class typically refers to a Perl module (Path::Class)
  for cross-platform path manipulation.\n\nTool homepage: http://metacpan.org/pod/Path::Class"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-path-class:0.37--pl526_1
stdout: perl-path-class.out
