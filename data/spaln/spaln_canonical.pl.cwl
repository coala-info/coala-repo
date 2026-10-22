cwlVersion: v1.2
class: CommandLineTool
baseCommand: canonical.pl
label: spaln_canonical.pl
doc: "canonical.pl: count the number of canonical intron boundaries (ATAC, GCAG, GTAG, others) in .eij files.\n\nTool homepage: https://github.com/ogotoh/spaln"
inputs:
  - id: eij_files
    type:
      type: array
      items: File
    doc: Exon-intron junction (.eij) files, e.g. from make_eij.pl or sortgrcd -O5 (*.eij)
    inputBinding:
      position: 200
outputs:
  - id: table
    type: stdout
    doc: Result table (stdout)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spaln:3.0.7--pl5321h077b44d_1
stdout: spaln_canonical.out
