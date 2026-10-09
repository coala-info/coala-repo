cwlVersion: v1.2
class: CommandLineTool
baseCommand: hhconsensus
label: hhsuite_hhconsensus
doc: "Calculate the consensus sequence for an A3M/FASTA input file.\n\nTool homepage: https://github.com/soedinglab/hh-suite"
inputs:
  - id: infile
    type: File
    doc: query alignment (A2M, A3M, or FASTA), or query HMM
    inputBinding:
      position: 101
      prefix: -i
  - id: sequence_file_path
    type: string
    doc: append consensus sequence in FASTA to this file (the tool default is <infile.seq>, beside the input)
    inputBinding:
      position: 102
      prefix: -s
  - id: output_a3m_path
    type:
      - 'null'
      - string
    doc: write alignment with consensus sequence in A3M
    inputBinding:
      position: 103
      prefix: -oa3m
  - id: output_a2m_path
    type:
      - 'null'
      - string
    doc: write alignment with consensus sequence in A2M
    inputBinding:
      position: 103
      prefix: -oa2m
  - id: output_fasta_path
    type:
      - 'null'
      - string
    doc: write alignment with consensus sequence in FASTA
    inputBinding:
      position: 103
      prefix: -ofas
  - id: verbose
    type:
      - 'null'
      - int
    doc: 'verbose mode: 0:no screen output  1:only warings  2: verbose'
    inputBinding:
      position: 104
      prefix: -v
  - id: max_pairwise_identity
    type:
      - 'null'
      - float
    doc: maximum pairwise sequence identity (%) (def=100)
    inputBinding:
      position: 104
      prefix: -id
  - id: diff
    type:
      - 'null'
      - float
    doc: filter most diverse set of sequences, keeping at least this many sequences in each block of >50 columns (def=0)
    inputBinding:
      position: 104
      prefix: -diff
  - id: min_coverage
    type:
      - 'null'
      - float
    doc: minimum coverage with query (%) (def=0)
    inputBinding:
      position: 104
      prefix: -cov
  - id: min_seq_identity
    type:
      - 'null'
      - float
    doc: minimum sequence identity with query (%) (def=0)
    inputBinding:
      position: 104
      prefix: -qid
  - id: min_score_per_column
    type:
      - 'null'
      - float
    doc: minimum score per column with query (def=-20.0)
    inputBinding:
      position: 104
      prefix: -qsc
  - id: input_format
    type:
      - 'null'
      - string
    doc: 'Input alignment format: a2m (default), first (FASTA, columns with residue in 1st sequence are match states) or a number 0-100 (FASTA, columns with fewer than X% gaps are match states)'
    inputBinding:
      position: 104
      prefix: -M
  - id: max_input_rows
    type:
      - 'null'
      - int
    doc: max number of input rows (def=65535)
    inputBinding:
      position: 104
      prefix: -maxseq
  - id: max_hmm_columns
    type:
      - 'null'
      - int
    doc: max number of HMM columns (def=20001)
    inputBinding:
      position: 104
      prefix: -maxres
outputs:
  - id: sequence_file
    type: File
    doc: consensus sequence in FASTA
    outputBinding:
      glob: $(inputs.sequence_file_path)
  - id: output_a3m
    type:
      - 'null'
      - File
    doc: alignment with consensus sequence in A3M
    outputBinding:
      glob: $(inputs.output_a3m_path)
  - id: output_a2m
    type:
      - 'null'
      - File
    doc: alignment with consensus sequence in A2M
    outputBinding:
      glob: $(inputs.output_a2m_path)
  - id: output_fasta
    type:
      - 'null'
      - File
    doc: alignment with consensus sequence in FASTA
    outputBinding:
      glob: $(inputs.output_fasta_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hhsuite:3.3.0--h503566f_15
