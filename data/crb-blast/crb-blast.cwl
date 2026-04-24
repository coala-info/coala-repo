cwlVersion: v1.2
class: CommandLineTool
baseCommand: crb-blast
label: crb-blast
doc: "Conditional Reciprocal Best BLAST\n\nTool homepage: https://github.com/cboursnell/crb-blast"
inputs:
  - id: evalue_cutoff
    type:
      - 'null'
      - float
    doc: e-value cut off for BLAST. Format 1e-5
    inputBinding:
      position: 101
      prefix: --evalue
  - id: query_file
    type: File
    doc: query fasta file
    inputBinding:
      position: 101
      prefix: --query
  - id: split
    type:
      - 'null'
      - boolean
    doc: split the fasta files into chunks and run multiple blast jobs and then 
      combine them.
    inputBinding:
      position: 101
      prefix: --split
  - id: target_file
    type: File
    doc: target fasta file
    inputBinding:
      position: 101
      prefix: --target
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to run BLAST with
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: be verbose
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file as tsv
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crb-blast:0.6.9--hdfd78af_0
