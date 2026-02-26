cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-file-contents
label: perl-test-file-contents
doc: "Tests if a file contains specific content.\n\nTool homepage: http://search.cpan.org/dist/Test-File-Contents/"
inputs:
  - id: file
    type: File
    doc: The file to test.
    inputBinding:
      position: 1
  - id: content
    type: string
    doc: The content to search for in the file.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-file-contents:0.23--0
stdout: perl-test-file-contents.out
