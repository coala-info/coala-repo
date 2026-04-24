cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqkit sum
label: seqkit_sum
doc: "compute message digest for all sequences in FASTA/Q files\n\nTool homepage:
  https://github.com/shenwei356/seqkit"
inputs:
  - id: all_info
    type:
      - 'null'
      - boolean
    doc: show all information, including the sequences length and the number of 
      sequences
    inputBinding:
      position: 101
      prefix: --all
  - id: alphabet_guess_seq_length
    type:
      - 'null'
      - int
    doc: length of sequence prefix of the first FASTA record based on which 
      seqkit guesses the sequence type (0 for whole seq)
    inputBinding:
      position: 101
  - id: basename
    type:
      - 'null'
      - boolean
    doc: only output basename of files
    inputBinding:
      position: 101
      prefix: --basename
  - id: circular
    type:
      - 'null'
      - boolean
    doc: the file contains a single cicular genome sequence
    inputBinding:
      position: 101
      prefix: --circular
  - id: compress_level
    type:
      - 'null'
      - int
    doc: compression level for gzip, zstd, xz and bzip2. type "seqkit -h" for 
      the range and default value for each format
    inputBinding:
      position: 101
  - id: gap_letters
    type:
      - 'null'
      - string
    doc: gap letters to delete with the flag -g/--remove-gaps
    inputBinding:
      position: 101
      prefix: --gap-letters
  - id: id_ncbi
    type:
      - 'null'
      - boolean
    doc: FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2| Pseud...
    inputBinding:
      position: 101
  - id: id_regexp
    type:
      - 'null'
      - string
    doc: regular expression for parsing ID
    inputBinding:
      position: 101
  - id: infile_list
    type:
      - 'null'
      - string
    doc: file of input files list (one file per line), if given, they are 
      appended to files from cli arguments
    inputBinding:
      position: 101
      prefix: --infile-list
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: k-mer size for processing circular genomes
    inputBinding:
      position: 101
      prefix: --kmer-size
  - id: line_width
    type:
      - 'null'
      - int
    doc: line width when outputting FASTA format (0 for no wrap)
    inputBinding:
      position: 101
      prefix: --line-width
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: be quiet and do not show extra information
    inputBinding:
      position: 101
  - id: remove_gaps
    type:
      - 'null'
      - boolean
    doc: remove gap characters set in the option -G/gap-letters
    inputBinding:
      position: 101
      prefix: --remove-gaps
  - id: rna2dna
    type:
      - 'null'
      - boolean
    doc: convert RNA to DNA
    inputBinding:
      position: 101
  - id: seq_type
    type:
      - 'null'
      - string
    doc: sequence type (dna|rna|protein|unlimit|auto) (for auto, it 
      automatically detect by the first sequence)
    inputBinding:
      position: 101
      prefix: --seq-type
  - id: single_strand
    type:
      - 'null'
      - boolean
    doc: only consider the positive strand of a circular genome, e.g., ssRNA 
      virus genomes
    inputBinding:
      position: 101
      prefix: --single-strand
  - id: skip_file_check
    type:
      - 'null'
      - boolean
    doc: skip input file checking when given a file list if you believe these 
      files do exist
    inputBinding:
      position: 101
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPUs. can also set with environment variable SEQKIT_THREADS)
    inputBinding:
      position: 101
      prefix: --threads
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
