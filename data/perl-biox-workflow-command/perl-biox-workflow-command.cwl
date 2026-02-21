cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-biox-workflow-command
label: perl-biox-workflow-command
doc: "A tool for managing bioinformatics workflows (Note: The provided text is an
  error log and does not contain help documentation for arguments).\n\nTool homepage:
  https://github.com/biosails/BioX-Workflow-Command"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-biox-workflow-command:2.4.1--pl5.22.0_0
stdout: perl-biox-workflow-command.out
