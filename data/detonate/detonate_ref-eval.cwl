cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ref-eval
label: detonate_ref-eval
doc: "REF-EVAL: A toolkit of reference-based scores for de novo transcriptome sequence
  assembly evaluation\n\nTool homepage: https://github.com/deweylab/detonate"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: scores
    type:
      - 'null'
      - type: array
        items: string
    doc: 'The groups of scores to compute: nucl, contig, pair (alignment-based),
      kmer, kc (alignment-free). Required unless --paper is given.'
    inputBinding:
      position: 101
      prefix: --scores
      itemSeparator: ','
  - id: weighted
    type:
      - 'null'
      - type: enum
        symbols:
          - 'yes'
          - 'no'
          - both
    doc: Compute weighted or unweighted variants of scores, or both. Required
      unless --paper or only --scores=kc is given.
    inputBinding:
      position: 101
      prefix: --weighted
  - id: paper
    type:
      - 'null'
      - boolean
    doc: Compute only the scores of the DETONATE paper (unweighted nucleotide F1,
      unweighted contig F1, weighted kmer compression score), instead of
      --scores and --weighted.
    inputBinding:
      position: 101
      prefix: --paper
  - id: a_seqs
    type: File
    doc: The assembly sequences, in FASTA format.
    inputBinding:
      position: 101
      prefix: --A-seqs
  - id: b_seqs
    type: File
    doc: The reference sequences, in FASTA format.
    inputBinding:
      position: 101
      prefix: --B-seqs
  - id: a_expr
    type:
      - 'null'
      - File
    doc: The assembly expression, as produced by RSEM in a file called
      *.isoforms.results. Required for weighted variants of scores.
    inputBinding:
      position: 101
      prefix: --A-expr
  - id: b_expr
    type:
      - 'null'
      - File
    doc: The reference expression, as produced by RSEM in a file called
      *.isoforms.results. Required for weighted variants of scores.
    inputBinding:
      position: 101
      prefix: --B-expr
  - id: a_to_b
    type:
      - 'null'
      - File
    doc: The alignments of the assembly to the reference (format set by
      --alignment-type). Required for alignment-based scores.
    inputBinding:
      position: 101
      prefix: --A-to-B
  - id: b_to_a
    type:
      - 'null'
      - File
    doc: The alignments of the reference to the assembly (format set by
      --alignment-type). Required for alignment-based scores.
    inputBinding:
      position: 101
      prefix: --B-to-A
  - id: alignment_type
    type:
      - 'null'
      - type: enum
        symbols:
          - psl
          - blast
    doc: 'The type of alignments used, either blast or psl. Default: psl.'
    inputBinding:
      position: 101
      prefix: --alignment-type
  - id: strand_specific
    type:
      - 'null'
      - boolean
    doc: Assume all assembly and reference sequences have the same orientation;
      ignore alignments or kmer matches to the reverse strand.
    inputBinding:
      position: 101
      prefix: --strand-specific
  - id: readlen
    type:
      - 'null'
      - int
    doc: Read length of the reads used to build the assembly. Required for KC
      scores.
    inputBinding:
      position: 101
      prefix: --readlen
  - id: num_reads
    type:
      - 'null'
      - long
    doc: Number of reads used to build the assembly. Required for KC scores.
    inputBinding:
      position: 101
      prefix: --num-reads
  - id: kmerlen
    type:
      - 'null'
      - int
    doc: Length ("k") of the kmers used in the KC and kmer scores. Required for
      KC and kmer scores.
    inputBinding:
      position: 101
      prefix: --kmerlen
  - id: min_frac_identity
    type:
      - 'null'
      - float
    doc: 'Contig scores only: alignments with fraction identity less than this
      threshold are ignored. Default: 0.99.'
    inputBinding:
      position: 101
      prefix: --min-frac-identity
  - id: max_frac_indel
    type:
      - 'null'
      - float
    doc: 'Contig scores only: alignments with fraction indel greater than this
      threshold are ignored. Default: 0.01.'
    inputBinding:
      position: 101
      prefix: --max-frac-indel
  - id: min_segment_len
    type:
      - 'null'
      - int
    doc: 'Nucleotide and pair scores only: alignment segments with fewer bases
      than this are discarded. Default: 100.'
    inputBinding:
      position: 101
      prefix: --min-segment-len
  - id: hash_table_type
    type:
      - 'null'
      - type: enum
        symbols:
          - sparse
          - dense
    doc: 'The type of hash table to use for KC and kmer scores. Default:
      sparse.'
    inputBinding:
      position: 101
      prefix: --hash-table-type
  - id: hash_table_numeric_type
    type:
      - 'null'
      - type: enum
        symbols:
          - double
          - float
    doc: 'The numeric type to store values in the hash table. Default: double.'
    inputBinding:
      position: 101
      prefix: --hash-table-numeric-type
  - id: hash_table_fudge_factor
    type:
      - 'null'
      - float
    doc: 'Initial hash table capacity is the worst-case number of kmers divided
      by this factor. Default: 2.0.'
    inputBinding:
      position: 101
      prefix: --hash-table-fudge-factor
  - id: trace
    type:
      - 'null'
      - string
    doc: Prefix for additional output with details about the scores (contig
      precision/recall matching TSV files).
    inputBinding:
      position: 101
      prefix: --trace
outputs:
  - id: scores_output
    type: stdout
    doc: The computed scores, one "name value" pair per line
  - id: trace_files
    type:
      type: array
      items: File
    doc: Contig matching TSV files written with --trace
    outputBinding:
      glob: "$(inputs.trace ? inputs.trace + '.*' : [])"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/detonate:1.11--boost1.64_1
stdout: detonate_ref-eval.scores.txt
