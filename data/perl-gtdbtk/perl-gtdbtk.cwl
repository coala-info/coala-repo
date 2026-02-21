cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-gtdbtk
label: perl-gtdbtk
doc: "The provided text is a container build error log (FATAL: Unable to handle docker
  uri... no space left on device) and does not contain the help text or usage information
  for the tool. As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/Ecogenomics/GTDBTk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-gtdbtk:0.1.5--pl526_0
stdout: perl-gtdbtk.out
