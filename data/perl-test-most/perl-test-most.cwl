cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-most
label: perl-test-most
doc: "The provided text does not contain help information or usage instructions; it
  consists of system error logs related to a container build failure (no space left
  on device) for the perl-test-most package.\n\nTool homepage: http://metacpan.org/pod/Test-Most"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-most:0.38--pl5321hdfd78af_0
stdout: perl-test-most.out
