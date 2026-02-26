cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqkit_grep
label: seqkit_grep
doc: "search sequences by ID/name/sequence/sequence motifs, mismatch allowed\n\nTool
  homepage: https://github.com/shenwei356/seqkit"
inputs:
  - id: allow_duplicated_patterns
    type:
      - 'null'
      - boolean
    doc: output records multiple times when duplicated patterns are given
    inputBinding:
      position: 101
      prefix: --allow-duplicated-patterns
  - id: alphabet_guess_seq_length
    type:
      - 'null'
      - int
    doc: length of sequence prefix of the first FASTA record based on which 
      seqkit guesses the sequence type (0 for whole seq)
    default: 10000
    inputBinding:
      position: 101
      prefix: --alphabet-guess-seq-length
  - id: by_name
    type:
      - 'null'
      - boolean
    doc: match by full name instead of just ID
    inputBinding:
      position: 101
      prefix: --by-name
  - id: by_seq
    type:
      - 'null'
      - boolean
    doc: search subseq on seq. Both positive and negative strand are searched by
      default, you might use -P/--only-positive-strand. Mismatch allowed using 
      flag -m/--max-mismatch
    inputBinding:
      position: 101
      prefix: --by-seq
  - id: circular
    type:
      - 'null'
      - boolean
    doc: circular genome
    inputBinding:
      position: 101
      prefix: --circular
  - id: compress_level
    type:
      - 'null'
      - int
    doc: compression level for gzip, zstd, xz and bzip2. type "seqkit -h" for 
      the range and default value for each format
    default: -1
    inputBinding:
      position: 101
      prefix: --compress-level
  - id: count
    type:
      - 'null'
      - boolean
    doc: just print a count of matching records. with the -v/--invert-match 
      flag, count non-matching records
    inputBinding:
      position: 101
      prefix: --count
  - id: degenerate
    type:
      - 'null'
      - boolean
    doc: pattern/motif contains degenerate base
    inputBinding:
      position: 101
      prefix: --degenerate
  - id: delete_matched
    type:
      - 'null'
      - boolean
    doc: delete a pattern right after being matched, this keeps the firstly 
      matched data and speedups when using regular expressions
    inputBinding:
      position: 101
      prefix: --delete-matched
  - id: id_ncbi
    type:
      - 'null'
      - boolean
    doc: FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2| Pseud...
    inputBinding:
      position: 101
      prefix: --id-ncbi
  - id: id_regexp
    type:
      - 'null'
      - string
    doc: regular expression for parsing ID
    default: ^(\S+)\s?
    inputBinding:
      position: 101
      prefix: --id-regexp
  - id: ignore_case
    type:
      - 'null'
      - boolean
    doc: ignore case
    inputBinding:
      position: 101
      prefix: --ignore-case
  - id: immediate_output
    type:
      - 'null'
      - boolean
    doc: print output immediately, do not use write buffer
    inputBinding:
      position: 101
      prefix: --immediate-output
  - id: infile_list
    type:
      - 'null'
      - File
    doc: file of input files list (one file per line), if given, they are 
      appended to files from cli arguments
    inputBinding:
      position: 101
      prefix: --infile-list
  - id: invert_match
    type:
      - 'null'
      - boolean
    doc: invert the sense of matching, to select non-matching records
    inputBinding:
      position: 101
      prefix: --invert-match
  - id: line_width
    type:
      - 'null'
      - int
    doc: line width when outputting FASTA format (0 for no wrap)
    default: 60
    inputBinding:
      position: 101
      prefix: --line-width
  - id: max_mismatch
    type:
      - 'null'
      - int
    doc: max mismatch when matching by seq. For large genomes like human genome,
      using mapping/alignment tools would be faster
    inputBinding:
      position: 101
      prefix: --max-mismatch
  - id: only_positive_strand
    type:
      - 'null'
      - boolean
    doc: only search on the positive strand
    inputBinding:
      position: 101
      prefix: --only-positive-strand
  - id: pattern
    type:
      - 'null'
      - type: array
        items: string
    doc: "search pattern. Multiple values supported: comma-separated (e.g., -p \"\
      p1,p2\") OR use -p multiple times (e.g., -p p1 -p p2). Make sure to quote literal
      commas, e.g. in regex patterns '\"A{2,}\"'"
    inputBinding:
      position: 101
      prefix: --pattern
  - id: pattern_file
    type:
      - 'null'
      - File
    doc: pattern file (one record per line)
    inputBinding:
      position: 101
      prefix: --pattern-file
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: be quiet and do not show extra information
    inputBinding:
      position: 101
      prefix: --quiet
  - id: region
    type:
      - 'null'
      - string
    doc: specify sequence region for searching. e.g 1:12 for first 12 bases, 
      -12:-1 for last 12 bases
    inputBinding:
      position: 101
      prefix: --region
  - id: seq_type
    type:
      - 'null'
      - string
    doc: sequence type (dna|rna|protein|unlimit|auto) (for auto, it 
      automatically detect by the first sequence)
    default: auto
    inputBinding:
      position: 101
      prefix: --seq-type
  - id: skip_file_check
    type:
      - 'null'
      - boolean
    doc: skip input file checking when given a file list if you believe these 
      files do exist
    inputBinding:
      position: 101
      prefix: --skip-file-check
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPUs. can also set with environment variable SEQKIT_THREADS)
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
  - id: use_regexp
    type:
      - 'null'
      - boolean
    doc: patterns are regular expression
    inputBinding:
      position: 101
      prefix: --use-regexp
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: out file ("-" for stdout, suffix .gz for gzipped out)
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
