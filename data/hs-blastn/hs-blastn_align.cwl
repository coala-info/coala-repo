cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hs-blastn
  - align
label: hs-blastn_align
doc: "Nucleotide-Nucleotide Aligner\n\nTool homepage: https://github.com/chenying2016/queries"
inputs:
  - id: db
    type:
      - 'null'
      - File
    doc: database name
    inputBinding:
      position: 101
      prefix: -db
  - id: dust
    type:
      - 'null'
      - string
    doc: "Filter query sequence with DUST (Format: 'yes', 'level window linker', or
      'no' to disable)"
    inputBinding:
      position: 101
      prefix: -dust
  - id: evalue
    type:
      - 'null'
      - float
    doc: Expectation value (E) threshold for saving hits
    inputBinding:
      position: 101
      prefix: -evalue
  - id: gapextend
    type:
      - 'null'
      - int
    doc: Cost to extend a gap
    inputBinding:
      position: 101
      prefix: -gapextend
  - id: gapopen
    type:
      - 'null'
      - int
    doc: Cost to open a gap
    inputBinding:
      position: 101
      prefix: -gapopen
  - id: max_target_seqs
    type:
      - 'null'
      - int
    doc: Maxinum number of aligned sequences to keep
    inputBinding:
      position: 101
      prefix: -max_target_seqs
  - id: min_raw_gapped_score
    type:
      - 'null'
      - int
    doc: Minimum raw gapped score to keep an alignment in the preliminary gapped
      and traceback stages
    inputBinding:
      position: 101
      prefix: -min_raw_gapped_score
  - id: num_alignments
    type:
      - 'null'
      - int
    doc: Number of database sequences to show alignments for
    inputBinding:
      position: 101
      prefix: -num_alignments
  - id: num_descriptions
    type:
      - 'null'
      - int
    doc: Number of database sequences to show one-line descriptions for
    inputBinding:
      position: 101
      prefix: -num_descriptions
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads (CPUs) to use in the search
    inputBinding:
      position: 101
      prefix: -num_threads
  - id: outfmt
    type:
      - 'null'
      - string
    doc: alignment view options (0 = pairwise, 6 = tabular, 7 = tabular with 
      comment lines)
    inputBinding:
      position: 101
      prefix: -outfmt
  - id: penalty
    type:
      - 'null'
      - int
    doc: Penalty for a nucleotide mismatch
    inputBinding:
      position: 101
      prefix: -penalty
  - id: perc_identity
    type:
      - 'null'
      - float
    doc: Percent identity
    inputBinding:
      position: 101
      prefix: -perc_identity
  - id: query
    type:
      - 'null'
      - File
    doc: Input file name (FASTA or FASTQ format), the base qualities in FASTQ 
      formated files will be ignored.
    inputBinding:
      position: 101
      prefix: -query
  - id: reward
    type:
      - 'null'
      - int
    doc: Reward for a nucleotide match
    inputBinding:
      position: 101
      prefix: -reward
  - id: word_size
    type:
      - 'null'
      - int
    doc: Word size for wordfiner algorithm (length of best perfect match)
    inputBinding:
      position: 101
      prefix: -word_size
  - id: xdrop_gap
    type:
      - 'null'
      - float
    doc: X-dropoff value (in bits) for preliminary gapped extensions
    inputBinding:
      position: 101
      prefix: -xdrop_gap
  - id: xdrop_gap_final
    type:
      - 'null'
      - float
    doc: X-dropoff value (in bits) for final gapped alignment
    inputBinding:
      position: 101
      prefix: -xdrop_gap_final
  - id: xdrop_ungap
    type:
      - 'null'
      - float
    doc: X-dropoff value (in bits) for ungapped extensions
    inputBinding:
      position: 101
      prefix: -xdrop_ungap
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hs-blastn:0.0.5--h9948957_6
