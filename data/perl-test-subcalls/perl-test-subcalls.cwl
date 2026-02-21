cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-subcalls
label: perl-test-subcalls
doc: "The provided text does not contain help information for the tool. It consists
  of container runtime logs and a fatal error indicating that the executable 'perl-test-subcalls'
  was not found in the system PATH.\n\nTool homepage: http://dev.perl.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-subcalls:1.10--pl526_1
stdout: perl-test-subcalls.out
