cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gia
  - get-fasta
label: gia_get-fasta
doc: "Extracts FASTA sequences using intervals from a BED file\n\nTool homepage: https://github.com/noamteyssier/gia"
inputs:
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Compression level to use for output files if applicable
    inputBinding:
      position: 101
      prefix: --compression-level
  - id: compression_threads
    type:
      - 'null'
      - int
    doc: Compression threads to use for output files if applicable
    inputBinding:
      position: 101
      prefix: --compression-threads
  - id: fasta
    type: File
    doc: "FASTA file to extract sequences from (assumes <fasta>.fai exists)\n    \
      \      \n          If the file ends with .gz, it will be treated as a BGZIP
      compressed file and decompressed on-the-fly. It will expect a corresponding
      .fai index and a gzip index file."
    inputBinding:
      position: 101
      prefix: --fasta
  - id: field_format
    type:
      - 'null'
      - string
    doc: "Allow for non-integer chromosome names\n          \n          [possible
      values: integer-based, string-based]"
    inputBinding:
      position: 101
      prefix: --field-format
  - id: input_bed_file
    type:
      - 'null'
      - File
    doc: Input BED file to process
    inputBinding:
      position: 101
      prefix: --input
  - id: input_format
    type:
      - 'null'
      - string
    doc: "Format of input file\n          \n          [possible values: bed3, bed4,
      bed6, gtf, bed12, ambiguous, bed-graph]"
    inputBinding:
      position: 101
      prefix: --input-format
  - id: rna
    type:
      - 'null'
      - boolean
    doc: The FASTA is RNA instead of DNA and reverse complement is handled 
      accordingly
    inputBinding:
      position: 101
      prefix: --rna
  - id: stranded
    type:
      - 'null'
      - boolean
    doc: Reverse complement the sequence if the strand is negative Default is to
      ignore strand information
    inputBinding:
      position: 101
      prefix: --stranded
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output BED file to write to
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gia:0.2.23--h588a25a_0
