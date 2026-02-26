cwlVersion: v1.2
class: CommandLineTool
baseCommand: hhfilter
label: hhsuite_hhfilter
doc: "Filter an alignment by maximum pairwise sequence identity, minimum coverage,
  minimum sequence identity, or score per column to the first (seed) sequence.\n\n\
  Tool homepage: https://github.com/soedinglab/hh-suite"
inputs:
  - id: filter_diverse_sequences
    type:
      - 'null'
      - int
    doc: filter MSA by selecting most diverse set of sequences, keeping at least
      this many seqs in each MSA block of length 50
    default: 0
    inputBinding:
      position: 101
      prefix: -diff
  - id: infile
    type: File
    doc: read input file in A3M/A2M or FASTA format
    inputBinding:
      position: 101
      prefix: -i
  - id: input_format
    type:
      - 'null'
      - string
    doc: 'Input alignment format: a2m (default), first, or percentage'
    inputBinding:
      position: 101
      prefix: -M
  - id: max_hmm_columns
    type:
      - 'null'
      - int
    doc: max number of HMM columns
    default: 20001
    inputBinding:
      position: 101
      prefix: -maxres
  - id: max_input_rows
    type:
      - 'null'
      - int
    doc: max number of input rows
    default: 65535
    inputBinding:
      position: 101
      prefix: -maxseq
  - id: max_pairwise_seq_identity
    type:
      - 'null'
      - float
    doc: maximum pairwise sequence identity (%)
    default: 90
    inputBinding:
      position: 101
      prefix: -id
  - id: min_coverage
    type:
      - 'null'
      - float
    doc: minimum coverage with query (%)
    default: 0
    inputBinding:
      position: 101
      prefix: -cov
  - id: min_score_per_column_with_query
    type:
      - 'null'
      - float
    doc: minimum score per column with query
    default: -20.0
    inputBinding:
      position: 101
      prefix: -qsc
  - id: min_seq_identity_with_query
    type:
      - 'null'
      - float
    doc: minimum sequence identity with query (%)
    default: 0
    inputBinding:
      position: 101
      prefix: -qid
  - id: target_diversity
    type:
      - 'null'
      - float
    doc: target diversity of alignment
    inputBinding:
      position: 101
      prefix: -neff
  - id: verbose
    type:
      - 'null'
      - int
    doc: 'verbose mode: 0:no screen output  1:only warings  2: verbose'
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: outfile
    type: File
    doc: write to output file in A3M format
    outputBinding:
      glob: $(inputs.outfile)
  - id: append_outfile
    type:
      - 'null'
      - File
    doc: append to output file in A3M format
    outputBinding:
      glob: $(inputs.append_outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hhsuite:3.3.0--h503566f_15
