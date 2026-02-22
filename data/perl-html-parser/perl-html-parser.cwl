cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-html-parser
label: perl-html-parser
doc: "The provided text does not contain help information or usage instructions; it
  is a system error log indicating a failure to pull a container image due to insufficient
  disk space.\n\nTool homepage: http://metacpan.org/pod/HTML::Parser"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-html-parser:3.83--pl5321h9948957_1
stdout: perl-html-parser.out
