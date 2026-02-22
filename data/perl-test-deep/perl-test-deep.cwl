cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-deep
label: perl-test-deep
doc: "Test::Deep - Extremely flexible deep comparison. Note: The provided text contains
  system error messages regarding disk space and container conversion rather than
  tool help documentation.\n\nTool homepage: http://github.com/rjbs/Test-Deep/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-deep:1.130--pl5321hdfd78af_0
stdout: perl-test-deep.out
