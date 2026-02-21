cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-attribute-handlers
label: perl-attribute-handlers
doc: "The provided text does not contain help information for the tool. It indicates
  a fatal error where the executable was not found in the system PATH.\n\nTool homepage:
  https://github.com/tsee/Attribute-Handlers"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-attribute-handlers:0.96--pl5.22.0_0
stdout: perl-attribute-handlers.out
