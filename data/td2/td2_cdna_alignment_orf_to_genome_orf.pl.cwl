cwlVersion: v1.2
class: CommandLineTool
baseCommand: td2_cdna_alignment_orf_to_genome_orf.pl
label: td2_cdna_alignment_orf_to_genome_orf.pl
doc: "The provided text contains system error messages related to container execution
  and disk space limitations rather than the tool's help documentation. No arguments
  could be extracted.\n\nTool homepage: https://github.com/Markusjsommer/TD2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/td2:1.0.7--pyhdfd78af_0
stdout: td2_cdna_alignment_orf_to_genome_orf.pl.out
