cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-text-diff
label: perl-text-diff
doc: "A tool to find differences between files or data sets (Note: The provided help
  text was an error log and did not contain usage details).\n\nTool homepage: http://metacpan.org/pod/Text-Diff"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-text-diff:1.45--pl526_0
stdout: perl-text-diff.out
