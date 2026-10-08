cwlVersion: v1.2
class: CommandLineTool
baseCommand: tama_fasta_splitter.py
label: gs-tama_tama_fasta_splitter.py
doc: "This script is used to split fasta files for running blastp in parallel\n\nTool homepage: https://github.com/sguizard/gs-tama"
inputs:
  - id: fasta_file
    type: File
    doc: Fasta file to split
    inputBinding:
      position: 1
  - id: output_prefix
    type: string
    doc: Output prefix; the pieces are named prefix_1.fa, prefix_2.fa, ...
    inputBinding:
      position: 2
  - id: number_of_files
    type: int
    doc: Number of files to split the fasta file into
    inputBinding:
      position: 3
outputs:
  - id: split_fasta_files
    type:
      type: array
      items: File
    doc: Split fasta files (prefix_N.fa)
    outputBinding:
      glob: $(inputs.output_prefix)_*.fa
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
