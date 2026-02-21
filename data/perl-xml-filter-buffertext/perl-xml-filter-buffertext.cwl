cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-xml-filter-buffertext
label: perl-xml-filter-buffertext
doc: "A Perl XML filter that ensures all characters() events are bundled into a single
  chunk. (Note: The provided input text indicates a failure to locate the executable
  and does not contain help documentation.)\n\nTool homepage: https://github.com/gooselinux/perl-XML-Filter-BufferText"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-xml-filter-buffertext:1.01--pl526_2
stdout: perl-xml-filter-buffertext.out
