cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-script
label: perl-test-script
doc: "A tool for testing Perl scripts. (Note: The provided text is an error log and
  does not contain usage instructions or argument definitions.)\n\nTool homepage:
  https://metacpan.org/pod/Test::Script"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-script:1.31--pl5321hdfd78af_0
stdout: perl-test-script.out
