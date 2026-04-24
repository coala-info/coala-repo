cwlVersion: v1.2
class: CommandLineTool
baseCommand: hhalign
label: hhsuite_hhalign
doc: "Align a query alignment/HMM to a template alignment/HMM by HMM-HMM alignment\n\
  \nTool homepage: https://github.com/soedinglab/hh-suite"
inputs:
  - id: alignment_format
    type:
      - 'null'
      - string
    doc: "use A2M/A3M (default): upper case = Match; lower case = Insert; '-' = Delete;
      '.' = gaps aligned to inserts (may be omitted) OR use FASTA: columns with residue
      in 1st sequence are match states OR use FASTA: columns with fewer than X% gaps
      are match states"
    inputBinding:
      position: 101
      prefix: -M
  - id: diverse_sequences_filter
    type:
      - 'null'
      - int
    doc: filter MSAs by selecting most diverse set of sequences, keeping at 
      least this many seqs in each MSA block of length 50
    inputBinding:
      position: 101
      prefix: -diff
  - id: generate_consensus
    type:
      - 'null'
      - boolean
    doc: generate consensus sequence as master sequence of query MSA
    inputBinding:
      position: 101
      prefix: -add_cons
  - id: global_alignment
    type:
      - 'null'
      - boolean
    doc: use global alignment mode for searching/ranking
    inputBinding:
      position: 101
      prefix: -glob
  - id: hide_consensus
    type:
      - 'null'
      - boolean
    doc: don't show consensus sequence in alignments
    inputBinding:
      position: 101
      prefix: -hide_cons
  - id: hide_dssp
    type:
      - 'null'
      - boolean
    doc: don't show DSSP 2ndary structure in alignments
    inputBinding:
      position: 101
      prefix: -hide_dssp
  - id: hide_predicted_ss
    type:
      - 'null'
      - boolean
    doc: don't show predicted 2ndary structure in alignments
    inputBinding:
      position: 101
      prefix: -hide_pred
  - id: local_alignment
    type:
      - 'null'
      - boolean
    doc: use local alignment mode for searching/ranking
    inputBinding:
      position: 101
      prefix: -loc
  - id: mact_threshold
    type:
      - 'null'
      - float
    doc: 'posterior prob threshold for MAC realignment controlling greediness at alignment
      ends: 0:global >0.1:local'
    inputBinding:
      position: 101
      prefix: -mact
  - id: mark_sequences
    type:
      - 'null'
      - boolean
    doc: do not filter out sequences marked by ">@"in their name line
    inputBinding:
      position: 101
      prefix: -mark
  - id: max_pairwise_identity
    type:
      - 'null'
      - float
    doc: maximum pairwise sequence identity
    inputBinding:
      position: 101
      prefix: -id
  - id: min_coverage
    type:
      - 'null'
      - float
    doc: minimum coverage with master sequence (%)
    inputBinding:
      position: 101
      prefix: -cov
  - id: min_score_per_column
    type:
      - 'null'
      - float
    doc: minimum score per column with master sequence
    inputBinding:
      position: 101
      prefix: -qsc
  - id: min_seq_identity_master
    type:
      - 'null'
      - float
    doc: minimum sequence identity with master sequence (%)
    inputBinding:
      position: 101
      prefix: -qid
  - id: neutralize_tags
    type:
      - 'null'
      - boolean
    doc: do neutralize His-, C-myc-, FLAG-tags, and trypsin recognition sequence
      to background distribution
    inputBinding:
      position: 101
      prefix: -tags
  - id: no_realign
    type:
      - 'null'
      - boolean
    doc: do NOT realign displayed hits with MAC algorithm
    inputBinding:
      position: 101
      prefix: -norealign
  - id: notags
    type:
      - 'null'
      - boolean
    doc: do NOT neutralize His-, C-myc-, FLAG-tags, and trypsin recognition 
      sequence to background distribution
    inputBinding:
      position: 101
      prefix: -notags
  - id: output_fasta_format
    type:
      - 'null'
      - string
    doc: write pairwise alignments in FASTA xor A2M (-Oa2m) xor A3M (-Oa3m) 
      format
    inputBinding:
      position: 101
      prefix: -Ofas
  - id: query
    type: File
    doc: 'input/query: single sequence or multiple sequence alignment (MSA) in a3m,
      a2m, or FASTA format, or HMM in hhm format'
    inputBinding:
      position: 101
      prefix: -i
  - id: show_ss_confidence
    type:
      - 'null'
      - boolean
    doc: show confidences for predicted 2ndary structure in alignments
    inputBinding:
      position: 101
      prefix: -show_ssconf
  - id: template
    type: File
    doc: 'input/template: single sequence or multiple sequence alignment (MSA) in
      a3m, a2m, or FASTA format, or HMM in hhm format'
    inputBinding:
      position: 101
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - int
    doc: 'verbose mode: 0:no screen output 1:only warings 2: verbose'
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: write results in standard format to file
    outputBinding:
      glob: $(inputs.output_file)
  - id: output_a3m_file
    type:
      - 'null'
      - File
    doc: write query alignment in a3m or PSI-BLAST format (-opsi) to file
    outputBinding:
      glob: $(inputs.output_a3m_file)
  - id: append_a3m_file
    type:
      - 'null'
      - File
    doc: append query alignment in a3m (-aa3m) or PSI-BLAST format (-apsi )to 
      file
    outputBinding:
      glob: $(inputs.append_a3m_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hhsuite:3.3.0--h503566f_15
