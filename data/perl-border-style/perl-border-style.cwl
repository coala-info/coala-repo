cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-border-style
label: perl-border-style
doc: "The tool 'perl-border-style' could not be executed as the file was not found
  in the system PATH.\n\nTool homepage: https://github.com/AI-TEENU/royal_teenu"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-border-style:0.01--pl526_2
stdout: perl-border-style.out
