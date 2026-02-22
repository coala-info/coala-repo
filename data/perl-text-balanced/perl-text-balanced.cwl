cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-text-balanced
label: perl-text-balanced
doc: "The provided text contains system error messages related to container image
  extraction and disk space issues rather than the tool's help documentation. As a
  result, no arguments or functional descriptions could be extracted.\n\nTool homepage:
  https://metacpan.org/pod/Text::Balanced"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-text-balanced:2.07--pl5321hdfd78af_0
stdout: perl-text-balanced.out
