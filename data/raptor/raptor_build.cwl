cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - raptor
  - build
label: raptor_build
doc: "Constructs a Raptor index. The input may be a layout file from raptor layout,\
  \ a list of minimiser files produced from raptor prepare, or a file with a list\
  \ of files to process.\n\nTool homepage: https://github.com/seqan/raptor"
inputs:
  - id: input
    type: File
    doc: A layout file from raptor layout, or a file containing file names. The file
      must contain at least one file path per line, with multiple paths being separated
      by a whitespace. Each line in the file corresponds to one bin. Valid extensions
      for the paths in the file are [minimiser] when using preprocessed input from
      raptor prepare, and [embl,fasta,fa,fna,ffn,faa,frn,fas,fastq,fq,genbank,gb,gbk,sam],
      possibly followed by [bz2,gz,bgzf]. The input file must exist and read permissions
      must be granted.
    inputBinding:
      position: 101
      prefix: --input
      valueFrom: $(self.basename)
  - id: bin_files
    type:
      type: array
      items: File
    doc: Sequence files (or minimiser files) named in the input file; staged in the
      working directory so the names resolve
  - id: output
    type: string
    doc: A valid path for the output file. Write permissions must be granted.
    inputBinding:
      position: 102
      prefix: --output
  - id: threads
    type:
      - 'null'
      - int
    doc: 'The number of threads to use. Default: 1. Value must be a positive integer.'
    inputBinding:
      position: 101
      prefix: --threads
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not print time and memory usage.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: kmer
    type:
      - 'null'
      - int
    doc: 'The k-mer size. Default: 20, or read from layout file. Value must be in
      range [1,32].'
    inputBinding:
      position: 101
      prefix: --kmer
  - id: window
    type:
      - 'null'
      - int
    doc: 'The window size. Default: k-mer size. Value must be a positive integer.'
    inputBinding:
      position: 101
      prefix: --window
  - id: shape
    type:
      - 'null'
      - string
    doc: 'The shape to use for k-mers. Mutually exclusive with --kmer. Parsed from
      right to left. Default: 11111111111111111111 (a k-mer of size 20), or read from
      layout file. Value must match the pattern ''[01]+''.'
    inputBinding:
      position: 101
      prefix: --shape
  - id: fpr
    type:
      - 'null'
      - float
    doc: 'The false positive rate. Default: 0.050000, or read from layout file. Value
      must be in range [0.000000,1.000000].'
    inputBinding:
      position: 101
      prefix: --fpr
  - id: hash
    type:
      - 'null'
      - int
    doc: 'The number of hash functions to use. Default: 2, or read from layout file.
      Value must be in range [1,5].'
    inputBinding:
      position: 101
      prefix: --hash
  - id: parts
    type:
      - 'null'
      - int
    doc: 'Splits the index in this many parts. Not available for the HIBF. Default:
      1. Value must be a power of two.'
    inputBinding:
      position: 101
      prefix: --parts
  - id: compressed
    type:
      - 'null'
      - boolean
    doc: Build a compressed index.
    inputBinding:
      position: 101
      prefix: --compressed
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (time and memory usage)
  - id: index_files
    type:
      type: array
      items: File
    doc: Raptor index (one file per part when --parts is used)
    outputBinding:
      glob: $(inputs.output)*
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input)
      - $(inputs.bin_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/raptor:3.0.1--haf24da9_4
stdout: raptor_build.out
