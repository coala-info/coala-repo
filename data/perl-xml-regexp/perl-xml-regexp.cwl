cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-xml-regexp
label: perl-xml-regexp
doc: "A Perl module/tool providing regular expressions for XML tokens. (Note: The
  provided text indicates an execution error and does not contain help documentation.)\n
  \nTool homepage: https://github.com/zszszszsz/.config"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-xml-regexp:0.04--pl526_1
stdout: perl-xml-regexp.out
