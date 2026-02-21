cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-gdgraph-histogram
label: perl-gdgraph-histogram
doc: The provided text is a system error log indicating a failed container build due
  to insufficient disk space ('no space left on device') and does not contain the
  help text or usage instructions for the tool.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-gdgraph-histogram:1.1--pl5.22.0_1
stdout: perl-gdgraph-histogram.out
