cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-experimental
label: perl-experimental
doc: "A tool for using experimental features of Perl. (Note: The provided text contains
  system error messages regarding container image conversion and does not include
  specific usage instructions or argument definitions.)\n\nTool homepage: http://metacpan.org/pod/experimental"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-experimental:0.036--pl5321hdfd78af_0
stdout: perl-experimental.out
