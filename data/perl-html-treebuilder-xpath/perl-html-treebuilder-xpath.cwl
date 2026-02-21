cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-html-treebuilder-xpath
label: perl-html-treebuilder-xpath
doc: "A Perl tool for parsing HTML and extracting information using XPath expressions.
  (Note: The provided help text contains only system logs and an execution error;
  no specific arguments or usage instructions were found in the input.)\n\nTool homepage:
  https://github.com/pld-linux/perl-HTML-TreeBuilder-XPath"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-html-treebuilder-xpath:0.14--pl526_1
stdout: perl-html-treebuilder-xpath.out
