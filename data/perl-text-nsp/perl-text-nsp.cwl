cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-text-nsp
label: perl-text-nsp
doc: "The Ngram Statistics Package (NSP) is a collection of Perl modules and programs
  that aid in analyzing Ngrams in large bodies of text. (Note: The provided input
  text contains execution logs and an error indicating the executable was not found,
  rather than the help documentation.)\n\nTool homepage: https://github.com/OpenMandrivaAssociation/perl-Text-NSP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-text-nsp:1.31--pl526_1
stdout: perl-text-nsp.out
