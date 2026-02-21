cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-text-template
label: perl-text-template
doc: "A Perl-based library or tool for processing text templates. Note: The provided
  help text indicates a fatal error where the executable was not found in the environment,
  so no specific arguments could be extracted from the output.\n\nTool homepage: https://github.com/VientoDigital/codegenerator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-text-template:1.46--pl5.22.0_0
stdout: perl-text-template.out
