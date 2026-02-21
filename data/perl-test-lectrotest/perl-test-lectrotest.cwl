cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-lectrotest
label: perl-test-lectrotest
doc: "A property-based testing system for Perl (LectroTest).\n\nTool homepage: http://metacpan.org/pod/Test::LectroTest"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-lectrotest:0.5001--pl526_0
stdout: perl-test-lectrotest.out
