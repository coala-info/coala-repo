cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-version-next
label: perl-version-next
doc: "The provided text is an error log indicating that the executable 'perl-version-next'
  was not found in the system PATH; therefore, no help text or argument information
  is available to parse.\n\nTool homepage: https://github.com/anyaMairead/Rihannsu-Language-Generator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-version-next:1.000--pl526_1
stdout: perl-version-next.out
