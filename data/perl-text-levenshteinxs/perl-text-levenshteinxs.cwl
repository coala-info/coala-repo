cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-text-levenshteinxs
label: perl-text-levenshteinxs
doc: "An implementation of the Levenshtein distance algorithm (XS version for Perl)\n
  \nTool homepage: http://metacpan.org/pod/Text::LevenshteinXS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-text-levenshteinxs:0.03--pl526h14c3975_0
stdout: perl-text-levenshteinxs.out
