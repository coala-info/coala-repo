cwlVersion: v1.2
class: CommandLineTool
baseCommand: add_length_column.py
label: cami-amber_add_length_column.py
doc: "Add length column _LENGTH to gold standard mapping and print mapping on the
  standard output\n\nTool homepage: https://github.com/CAMI-challenge/AMBER"
inputs:
  - id: fasta_file
    type: File
    doc: FASTA or FASTQ file with sequences of gold standard
    inputBinding:
      position: 101
      prefix: --fasta_file
  - id: gold_standard_file
    type: File
    doc: Gold standard - ground truth - file
    inputBinding:
      position: 101
      prefix: --gold_standard_file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cami-amber:2.0.7--pyhdfd78af_0
stdout: cami-amber_add_length_column.py.out
