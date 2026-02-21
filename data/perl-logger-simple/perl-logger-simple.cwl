cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-logger-simple
label: perl-logger-simple
doc: "The provided text does not contain help documentation or usage instructions;
  it consists of system logs indicating a failure to locate the executable.\n\nTool
  homepage: http://metacpan.org/pod/Logger::Simple"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-logger-simple:2.0--pl526_0
stdout: perl-logger-simple.out
