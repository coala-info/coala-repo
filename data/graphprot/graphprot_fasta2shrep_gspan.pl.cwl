cwlVersion: v1.2
class: CommandLineTool
baseCommand: graphprot_fasta2shrep_gspan.pl
label: graphprot_fasta2shrep_gspan.pl
doc: "A tool from the GraphProt suite, likely used for converting FASTA sequences
  into shrep/gspan format. (Note: The provided help text contains only system error
  messages regarding container execution and does not list usage or arguments.)\n\n
  Tool homepage: https://github.com/dmaticzka/graphprot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphprot:1.1.7--py36_0
stdout: graphprot_fasta2shrep_gspan.pl.out
