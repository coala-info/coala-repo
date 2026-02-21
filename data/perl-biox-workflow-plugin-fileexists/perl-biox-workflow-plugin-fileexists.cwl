cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-biox-workflow-plugin-fileexists
label: perl-biox-workflow-plugin-fileexists
doc: The provided text does not contain help information; it indicates a fatal error
  where the executable was not found in the system PATH.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-biox-workflow-plugin-fileexists:0.13--1
stdout: perl-biox-workflow-plugin-fileexists.out
