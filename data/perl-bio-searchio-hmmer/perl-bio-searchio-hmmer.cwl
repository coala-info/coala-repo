cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bio-searchio-hmmer
label: perl-bio-searchio-hmmer
doc: "A BioPerl-based tool for parsing HMMER search results. Note: The provided text
  contains system error logs regarding container image creation and does not list
  specific command-line arguments.\n\nTool homepage: https://metacpan.org/release/Bio-SearchIO-hmmer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-searchio-hmmer:1.7.3--pl5321hdfd78af_0
stdout: perl-bio-searchio-hmmer.out
