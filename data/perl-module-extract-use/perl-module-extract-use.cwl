cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-module-extract-use
label: perl-module-extract-use
doc: "A tool to extract used modules from Perl source code. (Note: The provided help
  text contained only execution logs and an error indicating the executable was not
  found; no specific arguments could be parsed from the input.)\n\nTool homepage:
  https://github.com/briandfoy/module-extract-use"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-module-extract-use:1.043--0
stdout: perl-module-extract-use.out
