cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-symbol
label: perl-symbol
doc: "The provided text does not contain help information or a description for the
  tool; it is an error log indicating the executable was not found.\n\nTool homepage:
  https://github.com/sugyan/Acme-HeptaSymbolize"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-symbol:1.07--pl526_1
stdout: perl-symbol.out
