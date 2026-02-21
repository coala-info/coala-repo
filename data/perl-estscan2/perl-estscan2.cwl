cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-estscan2
label: perl-estscan2
doc: The provided text does not contain help information for the tool. It is a system
  error log indicating a failure to build or pull the container image due to insufficient
  disk space.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-estscan2:2.1--pl526_2
stdout: perl-estscan2.out
