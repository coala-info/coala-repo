cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-html-entities-numbered
label: perl-html-entities-numbered
doc: "The provided text does not contain help information as the executable was not
  found in the environment. No arguments could be parsed.\n\nTool homepage: https://github.com/pld-linux/perl-HTML-Entities-Numbered"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-html-entities-numbered:0.04--pl526_1
stdout: perl-html-entities-numbered.out
