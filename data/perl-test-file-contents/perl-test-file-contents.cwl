cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-file-contents
label: perl-test-file-contents
doc: "A tool for testing the contents of files, typically associated with the Perl
  Test::File::Contents module. (Note: The provided input text contains execution logs
  and an error message rather than the standard help documentation.)\n\nTool homepage:
  http://search.cpan.org/dist/Test-File-Contents/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-file-contents:0.23--0
stdout: perl-test-file-contents.out
