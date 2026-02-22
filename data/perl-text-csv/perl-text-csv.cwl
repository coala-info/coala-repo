cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-text-csv
label: perl-text-csv
doc: "A Perl module for reading and writing Comma-Separated Value files. (Note: The
  provided text contains system error messages regarding disk space and container
  image retrieval rather than command-line help documentation.)\n\nTool homepage:
  http://metacpan.org/pod/Text::CSV"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-text-csv:2.01--pl5321hdfd78af_0
stdout: perl-text-csv.out
