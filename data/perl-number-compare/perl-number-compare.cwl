cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-number-compare
label: perl-number-compare
doc: "A tool for numeric comparisons (Note: The provided help text indicates a fatal
  error where the executable was not found, so no specific usage details or arguments
  could be extracted from the source text).\n\nTool homepage: https://github.com/melanieapreston/PuppyTails"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-number-compare:0.03--pl526_2
stdout: perl-number-compare.out
