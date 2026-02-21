cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-exception
label: perl-test-exception
doc: "The provided text does not contain help information as the executable was not
  found in the environment.\n\nTool homepage: https://github.com/Test-More/test-exception"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-exception:0.43--pl5.22.0_0
stdout: perl-test-exception.out
