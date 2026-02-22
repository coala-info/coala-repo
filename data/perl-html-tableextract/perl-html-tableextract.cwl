cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-html-tableextract
label: perl-html-tableextract
doc: "A tool for extracting content from HTML tables. (Note: The provided help text
  contained system error messages regarding disk space and did not include usage instructions
  or argument definitions.)\n\nTool homepage: https://metacpan.org/pod/HTML::TableExtract"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-html-tableextract:2.15--pl5321hdfd78af_0
stdout: perl-html-tableextract.out
