cwlVersion: v1.2
class: CommandLineTool
baseCommand: skc
label: skc
doc: "Shared k-mer content between two genomes\n\nTool homepage: https://github.com/mbhall88/skc"
inputs:
  - id: target
    type: File
    doc: "Target sequence (smallest of the two genomes recommended)\n          \n\
      \          Can be compressed with gzip, bzip2, xz, or zstd"
    inputBinding:
      position: 1
  - id: query
    type: File
    doc: "Query sequence\n          \n          Can be compressed with gzip, bzip2,
      xz, or zstd"
    inputBinding:
      position: 2
  - id: compress_level
    type:
      - 'null'
      - int
    doc: Compression level to use if compressing output
    inputBinding:
      position: 103
      prefix: --compress-level
  - id: kmer
    type:
      - 'null'
      - int
    doc: Size of k-mers (max. 32)
    inputBinding:
      position: 103
      prefix: --kmer
  - id: output_type
    type:
      - 'null'
      - string
    doc: "u: uncompressed; b: Bzip2; g: Gzip; l: Lzma; z: Zstd\n          \n     \
      \     Output compression format is automatically guessed from the filename extension.
      This option is used to override that"
    inputBinding:
      position: 103
      prefix: --output-type
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output filepath(s); stdout if not present
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/skc:0.1.0--h7b50bb2_1
