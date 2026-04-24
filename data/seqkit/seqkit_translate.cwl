cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqkit translate
label: seqkit_translate
doc: "translate DNA/RNA to protein sequence (supporting ambiguous bases)\n\nTool homepage:
  https://github.com/shenwei356/seqkit"
inputs:
  - id: allow_unknown_codon
    type:
      - 'null'
      - boolean
    doc: translate unknown code to 'X'. And you may not use flag --trim which 
      removes 'X'
    inputBinding:
      position: 101
      prefix: --allow-unknown-codon
  - id: alphabet_guess_seq_length
    type:
      - 'null'
      - int
    doc: length of sequence prefix of the first FASTA record based on which 
      seqkit guesses the sequence type (0 for whole seq) (default 10000)
    inputBinding:
      position: 101
      prefix: --alphabet-guess-seq-length
  - id: append_frame
    type:
      - 'null'
      - boolean
    doc: append frame information to sequence ID
    inputBinding:
      position: 101
      prefix: --append-frame
  - id: clean
    type:
      - 'null'
      - boolean
    doc: change all STOP codon positions from the '*' character to 'X' (an 
      unknown residue)
    inputBinding:
      position: 101
      prefix: --clean
  - id: compress_level
    type:
      - 'null'
      - int
    doc: compression level for gzip, zstd, xz and bzip2. type "seqkit -h" for 
      the range and default value for each format (default -1)
    inputBinding:
      position: 101
      prefix: --compress-level
  - id: frame
    type:
      - 'null'
      - string
    doc: 'frame(s) to translate, available value: 1, 2, 3, -1, -2, -3, and 6 for all
      six frames (default [1])'
    inputBinding:
      position: 101
      prefix: --frame
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
    doc: regular expression for parsing ID (default "^(\\S+)\\s?")
    inputBinding:
      position: 101
      prefix: --id-regexp
  - id: infile_list
    type:
      - 'null'
      - string
    doc: file of input files list (one file per line), if given, they are 
      appended to files from cli arguments
    inputBinding:
      position: 101
      prefix: --infile-list
  - id: init_codon_as_m
    type:
      - 'null'
      - boolean
    doc: translate initial codon at beginning to 'M'
    inputBinding:
      position: 101
      prefix: --init-codon-as-M
  - id: line_width
    type:
      - 'null'
      - int
    doc: line width when outputting FASTA format (0 for no wrap) (default 60)
    inputBinding:
      position: 101
      prefix: --line-width
  - id: list_transl_table
    type:
      - 'null'
      - int
    doc: show details of translate table N, 0 for all (default -1)
    inputBinding:
      position: 101
      prefix: --list-transl-table
  - id: list_transl_table_with_amb_codons
    type:
      - 'null'
      - int
    doc: show details of translate table N (including ambigugous codons), 0 for 
      all.  (default -1)
    inputBinding:
      position: 101
      prefix: --list-transl-table-with-amb-codons
  - id: min_len
    type:
      - 'null'
      - int
    doc: the minimum length of amino acid sequence
    inputBinding:
      position: 101
      prefix: --min-len
  - id: out_subseqs
    type:
      - 'null'
      - boolean
    doc: output individual amino acid subsequences seperated by the stop symbol 
      "*"
    inputBinding:
      position: 101
      prefix: --out-subseqs
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: be quiet and do not show extra information
    inputBinding:
      position: 101
      prefix: --quiet
  - id: seq_type
    type:
      - 'null'
      - string
    doc: sequence type (dna|rna|protein|unlimit|auto) (for auto, it 
      automatically detect by the first sequence) (default "auto")
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
  - id: skip_translate_errors
    type:
      - 'null'
      - boolean
    doc: skip errors during translate and output blank sequence
    inputBinding:
      position: 101
      prefix: --skip-translate-errors
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPUs. can also set with environment variable SEQKIT_THREADS) 
      (default 4)
    inputBinding:
      position: 101
      prefix: --threads
  - id: transl_table
    type:
      - 'null'
      - int
    doc: translate table/genetic code, type 'seqkit translate --help' for more 
      details (default 1)
    inputBinding:
      position: 101
      prefix: --transl-table
  - id: trim
    type:
      - 'null'
      - boolean
    doc: remove all 'X' and '*' characters from the right end of the translation
    inputBinding:
      position: 101
      prefix: --trim
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
