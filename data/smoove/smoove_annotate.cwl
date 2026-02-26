cwlVersion: v1.2
class: CommandLineTool
baseCommand: smoove
label: smoove_annotate
doc: "GFF3 annotation files can be downloaded from Ensembl:\nftp://ftp.ensembl.org/pub/current_gff3/homo_sapiens/\n\
  ftp://ftp.ensembl.org/pub/grch37/release-84/gff3/homo_sapiens/\n\nTool homepage:
  https://github.com/brentp/smoove"
inputs:
  - id: vcf
    type: File
    doc: path to VCF(s) to annotate.
    inputBinding:
      position: 1
  - id: gff
    type:
      - 'null'
      - File
    doc: path to GFF for gene annotation
    inputBinding:
      position: 102
      prefix: --gff
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smoove:0.2.8--h9ee0642_1
stdout: smoove_annotate.out
