cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-utf8
label: perl-test-utf8
doc: "The provided text does not contain help information or a description of the
  tool; it contains system error messages related to container image pulling and disk
  space issues.\n\nTool homepage: https://github.com/2shortplanks/Test-utf8/tree"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-utf8:1.03--pl5321hdfd78af_0
stdout: perl-test-utf8.out
