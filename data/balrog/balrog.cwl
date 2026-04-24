cwlVersion: v1.2
class: CommandLineTool
baseCommand: balrog
label: balrog
doc: "Balrog (Bacterial Annotation by Likelihood Ratio of Gene-models) is a prokaryotic
  gene finder that uses temporal convolutional networks to score potential open reading
  frames.\n\nTool homepage: https://github.com/Markusjsommer/BalrogCPP"
inputs:
  - id: input_fasta
    type: File
    doc: Input genome sequence in FASTA format
    inputBinding:
      position: 101
      prefix: --input
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum ORF length in amino acids
    inputBinding:
      position: 101
      prefix: --min_len
  - id: model
    type:
      - 'null'
      - string
    doc: Path to a specific Balrog model file
    inputBinding:
      position: 101
      prefix: --model
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: translation_table
    type:
      - 'null'
      - int
    doc: Translation table (genetic code) to use
    inputBinding:
      position: 101
      prefix: --genome
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file for gene predictions (GFF3 format)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/balrog:0.5.1--he513fc3_0
