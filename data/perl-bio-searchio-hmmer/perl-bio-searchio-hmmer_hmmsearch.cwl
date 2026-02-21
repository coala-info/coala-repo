cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bio-searchio-hmmer_hmmsearch
label: perl-bio-searchio-hmmer_hmmsearch
doc: "A tool for parsing HMMER hmmsearch output using BioPerl's SearchIO module. (Note:
  The provided input text appears to be a system error log regarding a failed container
  build due to insufficient disk space and does not contain the actual help documentation
  for the tool.)\n\nTool homepage: https://metacpan.org/release/Bio-SearchIO-hmmer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-searchio-hmmer:1.7.3--pl5321hdfd78af_0
stdout: perl-bio-searchio-hmmer_hmmsearch.out
