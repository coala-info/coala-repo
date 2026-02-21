cwlVersion: v1.2
class: CommandLineTool
baseCommand: pepgenome
label: pepgenome
doc: "A tool for mapping peptide identifications to genomic coordinates using protein
  sequences and genome annotations.\n\nTool homepage: https://github.com/bigbio/pgatk/"
inputs:
  - id: chr_prefix
    type:
      - 'null'
      - int
    doc: Export chr prefix Allowed 0, 1
    default: 0
    inputBinding:
      position: 101
      prefix: -chr
  - id: fasta
    type: File
    doc: Filepath for file containing protein sequences in FASTA format
    inputBinding:
      position: 101
      prefix: -fasta
  - id: format
    type:
      - 'null'
      - string
    doc: Select the output formats from gtf, gct, bed, ptmbed, all or combinations
      thereof separated by ','
    default: all
    inputBinding:
      position: 101
      prefix: -format
  - id: genome
    type:
      - 'null'
      - File
    doc: Filepath for file containing genome sequence in FASTA format used to extract
      chromosome names and order
    inputBinding:
      position: 101
      prefix: -genome
  - id: gtf
    type: File
    doc: Filepath for file containing genome annotation in GTF format
    inputBinding:
      position: 101
      prefix: -gtf
  - id: in_memory
    type:
      - 'null'
      - int
    doc: Compute the kmer algorithm in memory (0) or using database algorithm (1)
    default: 0
    inputBinding:
      position: 101
      prefix: -inm
  - id: input_files
    type:
      type: array
      items: File
    doc: Comma(,) separated file paths for files containing peptide identifications
      (tsv, mzTab, or mzIdentML)
    inputBinding:
      position: 101
      prefix: -in
  - id: input_format
    type:
      - 'null'
      - string
    doc: Format of the input file (mztab, mzid, or tsv)
    default: tsv
    inputBinding:
      position: 101
      prefix: -inf
  - id: merge
    type:
      - 'null'
      - boolean
    doc: Set 'true' to merge mappings from all files from input
    default: false
    inputBinding:
      position: 101
      prefix: -merge
  - id: mismatch_mode
    type:
      - 'null'
      - boolean
    doc: 'Mismatch mode (true or false): if true mismatching with two mismatches will
      only allow 1 mismatch every kmersize (default: 5) positions.'
    default: false
    inputBinding:
      position: 101
      prefix: -mmmode
  - id: mismatches
    type:
      - 'null'
      - int
    doc: Allowed mismatches (0, 1 or 2)
    default: 0
    inputBinding:
      position: 101
      prefix: -mm
  - id: source
    type:
      - 'null'
      - string
    doc: Source name which will be used in the second column in the output gtf file
    default: PoGo
    inputBinding:
      position: 101
      prefix: -source
  - id: spark_master
    type:
      - 'null'
      - string
    doc: 'Spark master String. i.e., to run locally use: local[*]'
    inputBinding:
      position: 101
      prefix: -spark_master
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pepgenome:1.1.beta--0
stdout: pepgenome.out
