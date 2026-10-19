cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - select_best_rbcontig_plus_read1.pl
label: rainbow_select_best_rbcontig_plus_read1
doc: "Selects the best contig of each cluster plus read 1 sequences from a rainbow\
  \ merge output and the matching rainbow div output.\n\nTool homepage: https://sourceforge.net/projects/bio-rainbow/"
inputs:
  - id: rbasm_file
    type: File
    doc: rbasmed file (output of rainbow merge -a)
    inputBinding:
      position: 1
  - id: rbdiv_file
    type: File
    doc: rbdiv output file (output of rainbow div)
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Selected contigs in FASTA format
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rainbow:2.0.4--pl5321h7b50bb2_11
stdout: rainbow_select_best_rbcontig_plus_read1.fasta
