cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bio-db-refseq
label: perl-bio-db-refseq
doc: "BioPerl interface to the RefSeq database. Note: The provided text contains system
  error messages regarding disk space and container extraction rather than command-line
  help documentation.\n\nTool homepage: https://metacpan.org/release/Bio-DB-RefSeq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-db-refseq:1.7.4--pl5321hdfd78af_0
stdout: perl-bio-db-refseq.out
