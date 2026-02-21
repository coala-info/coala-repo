cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-text-soundex
label: perl-text-soundex
doc: "Implementation of the Soundex Algorithm (Phonetic hashing). Note: The provided
  input text contains execution logs and an error indicating the executable was not
  found, rather than standard help documentation.\n\nTool homepage: https://github.com/sclorg-distgit/perl-Text-Soundex"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-text-soundex:3.05--0
stdout: perl-text-soundex.out
