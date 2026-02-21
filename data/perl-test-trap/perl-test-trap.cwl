cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-trap
label: perl-test-trap
doc: "The provided text does not contain help information for the tool. It appears
  to be an error log indicating that the executable was not found in the environment.\n
  \nTool homepage: https://metacpan.org/pod/Test::Trap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-trap:0.3.3--pl526_0
stdout: perl-test-trap.out
