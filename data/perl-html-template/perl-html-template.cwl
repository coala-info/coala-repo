cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-html-template
label: perl-html-template
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating that the executable 'perl-html-template' was not found in the system
  PATH.\n\nTool homepage: https://metacpan.org/pod/HTML::Template"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-html-template:2.97--pl526_1
stdout: perl-html-template.out
