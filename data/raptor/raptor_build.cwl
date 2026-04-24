cwlVersion: v1.2
class: CommandLineTool
baseCommand: raptor build
label: raptor_build
doc: "Constructs a Raptor index.\n\nTool homepage: https://github.com/seqan/raptor"
inputs:
  - id: advanced_help
    type:
      - 'null'
      - boolean
    doc: Prints the help page including advanced options.
    inputBinding:
      position: 101
      prefix: --advanced-help
  - id: compressed
    type:
      - 'null'
      - boolean
    doc: Build a compressed index.
    inputBinding:
      position: 101
      prefix: --compressed
  - id: export_help
    type:
      - 'null'
      - string
    doc: "Export the help page information. Value must be one of [html, man,\nctd,
      cwl]."
    inputBinding:
      position: 101
      prefix: --export-help
  - id: fpr
    type:
      - 'null'
      - float
    doc: "The false positive rate. Default: 0.050000, or read from layout\nfile. Value
      must be in range [0.000000,1.000000]."
    inputBinding:
      position: 101
      prefix: --fpr
  - id: hash
    type:
      - 'null'
      - int
    doc: "The number of hash functions to use. Default: 2, or read from layout\nfile.
      Value must be in range [1,5]."
    inputBinding:
      position: 101
      prefix: --hash
  - id: input
    type: File
    doc: "A layout file from raptor layout, or a file containing file names.\nThe
      file must contain at least one file path per line, with multiple\npaths being
      separated by a whitespace. Each line in the file\ncorresponds to one bin. Valid
      extensions for the paths in the file\nare [minimiser] when using preprocessed
      input from raptor prepare,\nand [embl,fasta,fa,fna,ffn,faa,frn,fas,fastq,fq,genbank,gb,gbk,sam],\n\
      possibly followed by [bz2,gz,bgzf]. The input file must exist and\nread permissions
      must be granted."
    inputBinding:
      position: 101
      prefix: --input
  - id: kmer
    type:
      - 'null'
      - int
    doc: "The k-mer size. Default: 20, or read from layout file. Value must be\nin
      range [1,32]."
    inputBinding:
      position: 101
      prefix: --kmer
  - id: parts
    type:
      - 'null'
      - int
    doc: "Splits the index in this many parts. Not available for the HIBF.\nDefault:
      1. Value must be a power of two."
    inputBinding:
      position: 101
      prefix: --parts
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not print time and memory usage.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: shape
    type:
      - 'null'
      - string
    doc: "The shape to use for k-mers. Mutually exclusive with --kmer. Parsed\nfrom
      right to left. Default: 11111111111111111111 (a k-mer of size\n20), or read
      from layout file. Value must match the pattern '[01]+'."
    inputBinding:
      position: 101
      prefix: --shape
  - id: threads
    type:
      - 'null'
      - int
    doc: "The number of threads to use. Default: 1. Value must be a positive\ninteger."
    inputBinding:
      position: 101
      prefix: --threads
  - id: window
    type:
      - 'null'
      - int
    doc: "The window size. Default: k-mer size. Value must be a positive\ninteger."
    inputBinding:
      position: 101
      prefix: --window
outputs:
  - id: output
    type: File
    doc: A valid path for the output file. Write permissions must be granted.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/raptor:3.0.1--haf24da9_4
