cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-xml-sax-writer
label: perl-xml-sax-writer
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a system log indicating that the executable was not found
  in the environment.\n\nTool homepage: https://github.com/perigrin/xml-sax-writer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-xml-sax-writer:0.57--pl526_0
stdout: perl-xml-sax-writer.out
