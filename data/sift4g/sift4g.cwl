cwlVersion: v1.2
class: CommandLineTool
baseCommand: sift4g
label: sift4g
doc: "SIFT4G: a fast and accurate tool for predicting the functional impact of protein
  sequence variants.\n\nTool homepage: http://sift.bii.a-star.edu.sg/sift4g/"
inputs:
  - id: algorithm
    type:
      - 'null'
      - string
    doc: 'algorithm used for alignment, must be one of the following: SW - Smith-Waterman
      local alignment, NW - Needleman-Wunsch global alignment, HW - semiglobal alignment,
      OV - overlap alignment'
    inputBinding:
      position: 101
      prefix: --algorithm
  - id: cards
    type:
      - 'null'
      - string
    doc: list of cards should be given as an array of card indexes delimited 
      with nothing, for example usage of first two cards is given as --cards 01
    inputBinding:
      position: 101
      prefix: --cards
  - id: database_file
    type: File
    doc: input fasta database file
    inputBinding:
      position: 101
      prefix: --database
  - id: evalue
    type:
      - 'null'
      - float
    doc: evalue threshold, alignments with higher evalue are filtered, must be 
      given as a positive float
    inputBinding:
      position: 101
      prefix: --evalue
  - id: gap_extend
    type:
      - 'null'
      - int
    doc: gap extension penalty, must be given as a positive integer and must be 
      less or equal to gap opening penalty
    inputBinding:
      position: 101
      prefix: --gap-extend
  - id: gap_open
    type:
      - 'null'
      - int
    doc: gap opening penalty, must be given as a positive integer
    inputBinding:
      position: 101
      prefix: --gap-open
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: 'length of kmers used for database search, possible values: 3, 4, 5'
    inputBinding:
      position: 101
      prefix: --kmer-length
  - id: matrix
    type:
      - 'null'
      - string
    doc: 'similarity matrix, can be one of the following: BLOSUM_45, BLOSUM_50, BLOSUM_62,
      BLOSUM_80, BLOSUM_90, BLOSUM_30, BLOSUM_70, BLOSUM_250'
    inputBinding:
      position: 101
      prefix: --matrix
  - id: max_aligns
    type:
      - 'null'
      - int
    doc: maximum number of alignments to be outputted
    inputBinding:
      position: 101
      prefix: --max-aligns
  - id: max_candidates
    type:
      - 'null'
      - int
    doc: number of database sequences passed on to the Smith-Waterman part
    inputBinding:
      position: 101
      prefix: --max-candidates
  - id: median_threshold
    type:
      - 'null'
      - float
    doc: represents alignment diversity, used to output only a set of alignments
    inputBinding:
      position: 101
      prefix: --median-threshold
  - id: outfmt
    type:
      - 'null'
      - string
    doc: 'out format for the alignment file, must be one of the following: bm0 - blast
      m0 output format, bm8 - blast m8 tabular output format, bm9 - blast m9 commented
      tabular output format, light - score-name tabbed output'
    inputBinding:
      position: 101
      prefix: --outfmt
  - id: query_file
    type: File
    doc: input fasta query file
    inputBinding:
      position: 101
      prefix: --query
  - id: seq_id
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --seq-id
  - id: sub_results
    type:
      - 'null'
      - boolean
    doc: prints sub results (alignment file and a file per query containing its 
      selected alignments forp rediction) to same directory defined with --out
    inputBinding:
      position: 101
      prefix: --sub-results
  - id: subst_dir
    type:
      - 'null'
      - Directory
    doc: directory containing substitution files for each query (extension 
      .subst) files must have the same name as their corresponding query in 
      FASTA file
    inputBinding:
      position: 101
      prefix: --subst
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads used in thread pool
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: output directory for SIFT predictions
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sift4g:2.0.0--h503566f_8
