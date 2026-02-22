cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-files
label: perl-test-files
doc: "The provided text contains system error messages related to a container execution
  failure (no space left on device) and does not contain help documentation or usage
  instructions for the tool. As a result, no arguments could be extracted.\n\nTool
  homepage: http://metacpan.org/pod/Test::Files"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-files:0.15--pl5321hdfd78af_0
stdout: perl-test-files.out
