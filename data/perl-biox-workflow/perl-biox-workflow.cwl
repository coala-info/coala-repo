cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-biox-workflow
label: perl-biox-workflow
doc: 'A tool for managing bioinformatics workflows (Note: The provided help text contains
  only system logs and an execution error; no specific arguments or descriptions were
  found in the input).'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-biox-workflow:1.10--0
stdout: perl-biox-workflow.out
