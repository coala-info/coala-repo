cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-nowarnings
label: perl-test-nowarnings
doc: "A Perl module/tool to check that no warnings are emitted during testing.\n\n\
  Tool homepage: https://metacpan.org/pod/Test::NoWarnings"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-test-nowarnings:1.06--pl5321hdfd78af_0
stdout: perl-test-nowarnings.out
