cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - select_best_rbcontig.pl
label: rainbow_select_best_rbcontig
doc: "Selects the best contig of each cluster from a rainbow merge output and prints\
  \ it in FASTA format.\n\nTool homepage: https://sourceforge.net/projects/bio-rainbow/"
inputs:
  - id: rbasm_file
    type: File
    doc: rbasmed file (output of rainbow merge -a)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Selected contigs in FASTA format
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rainbow:2.0.4--pl5321h7b50bb2_11
stdout: rainbow_select_best_rbcontig.fasta
