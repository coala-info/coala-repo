cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-xml-xpathengine
label: perl-xml-xpathengine
doc: "A tool for XPath engine processing (Note: No help text was provided in the input
  to extract specific descriptions or arguments).\n\nTool homepage: https://github.com/gooselinux/perl-XML-XPathEngine"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-xml-xpathengine:0.14--pl526_1
stdout: perl-xml-xpathengine.out
