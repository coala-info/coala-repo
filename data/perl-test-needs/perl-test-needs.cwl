cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-needs
label: perl-test-needs
doc: "A tool related to the Perl Test::Needs module (Note: The provided text contains
  only system error messages and no help documentation to parse).\n\nTool homepage:
  http://metacpan.org/pod/Test::Needs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-needs:0.002009--pl5321hdfd78af_0
stdout: perl-test-needs.out
