cwlVersion: v1.2
class: CommandLineTool
baseCommand: eij4mer.pl
label: spaln_eij4mer.pl
doc: "eij4mer.pl: count the tetramers (donor and acceptor dinucleotides) flanking introns in .eij files.\n\nTool homepage: https://github.com/ogotoh/spaln"
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
stdout: spaln_eij4mer.out
