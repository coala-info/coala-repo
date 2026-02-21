cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-text-levenshtein
label: perl-text-levenshtein
doc: "A tool for calculating the Levenshtein edit distance (Note: The provided help
  text indicates a fatal error where the executable was not found, so no arguments
  could be extracted).\n\nTool homepage: https://github.com/neilbowers/Text-Levenshtein"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-text-levenshtein:0.13--pl526_0
stdout: perl-text-levenshtein.out
