cwlVersion: v1.2
class: CommandLineTool
baseCommand: td2_gtf_to_alignment_gff3.pl
label: td2_gtf_to_alignment_gff3.pl
doc: "A script to convert GTF format to alignment GFF3 format (Note: The provided
  help text contained system error messages rather than usage instructions; no arguments
  could be extracted from the input).\n\nTool homepage: https://github.com/Markusjsommer/TD2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/td2:1.0.7--pyhdfd78af_0
stdout: td2_gtf_to_alignment_gff3.pl.out
