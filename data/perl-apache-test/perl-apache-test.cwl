cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-apache-test
label: perl-apache-test
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a system error log indicating a 'no space left on device'
  failure during a container image conversion process.\n\nTool homepage: http://metacpan.org/pod/Apache::Test"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-apache-test:1.43--pl5321hdfd78af_0
stdout: perl-apache-test.out
