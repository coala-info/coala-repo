cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-pdf-api2
label: perl-pdf-api2
doc: "A Perl module for creating and modifying PDF files. (Note: The provided text
  contains system error messages regarding container execution and does not include
  CLI help documentation.)\n\nTool homepage: http://metacpan.org/pod/PDF::API2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-pdf-api2:2.043--pl5321hdfd78af_0
stdout: perl-pdf-api2.out
