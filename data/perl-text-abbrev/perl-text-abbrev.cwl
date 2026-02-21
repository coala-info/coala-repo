cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-text-abbrev
label: perl-text-abbrev
doc: "A tool to create an abbreviation table from a list of strings. (Note: The provided
  help text contains only system logs and an execution error; no specific argument
  definitions were found in the input.)\n\nTool homepage: http://search.cpan.org/dist/Text-Abbrev"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-text-abbrev:1.02--pl526_0
stdout: perl-text-abbrev.out
