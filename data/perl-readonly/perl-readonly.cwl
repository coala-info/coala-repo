cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-readonly
label: perl-readonly
doc: "The provided text does not contain help information for the tool; it is an error
  log indicating that the executable was not found in the environment.\n\nTool homepage:
  https://github.com/sanko/readonly"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-readonly:2.05--pl526_0
stdout: perl-readonly.out
