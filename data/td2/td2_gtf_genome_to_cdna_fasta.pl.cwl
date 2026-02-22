cwlVersion: v1.2
class: CommandLineTool
baseCommand: td2_gtf_genome_to_cdna_fasta.pl
label: td2_gtf_genome_to_cdna_fasta.pl
doc: "A tool to convert genome FASTA and GTF annotations into cDNA FASTA sequences.\n\
  \nTool homepage: https://github.com/Markusjsommer/TD2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/td2:1.0.7--pyhdfd78af_0
stdout: td2_gtf_genome_to_cdna_fasta.pl.out
