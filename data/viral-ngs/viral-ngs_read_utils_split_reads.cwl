cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - read_utils.py
  - split_reads
label: viral-ngs_read_utils_split_reads
doc: "Split fasta or fastq file into chunks of maxReads reads or into numChunks chunks named outPrefix01, outPrefix02, etc. If both maxReads and numChunks are None, use defaultMaxReads. The number of characters in file names after outPrefix is indexLen; if not specified, use defaultIndexLen.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: in_file_name
    type: File
    doc: "Input fastq or fasta file."
    inputBinding:
      position: 1
  - id: out_prefix
    type: string
    doc: "Output files will be named ${outPrefix}01${outSuffix}, ${outPrefix}02${outSuffix}..."
    inputBinding:
      position: 2
  - id: max_reads
    type:
      - 'null'
      - int
    doc: "Maximum number of reads per chunk (default 1000 if neither maxReads nor numChunks is specified)."
    inputBinding:
      position: 20
      prefix: --maxReads
  - id: num_chunks
    type:
      - 'null'
      - int
    doc: "Number of output files, if maxReads is not specified."
    inputBinding:
      position: 20
      prefix: --numChunks
  - id: index_len
    type:
      - 'null'
      - int
    doc: "Number of characters to append to outputPrefix for each output file (default 2). Number of files must not exceed 10^INDEXLEN."
    inputBinding:
      position: 20
      prefix: --indexLen
  - id: format
    type:
      - 'null'
      - type: enum
        symbols:
          - fastq
          - fasta
    doc: "Input fastq or fasta file (default: fastq)."
    inputBinding:
      position: 20
      prefix: --format
  - id: out_suffix
    type:
      - 'null'
      - string
    doc: "Output filename suffix (e.g. .fastq or .fastq.gz). A suffix ending in .gz will cause the output file to be gzip compressed. Default is no suffix."
    inputBinding:
      position: 20
      prefix: --outSuffix
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: out_chunks
    type:
      type: array
      items: File
    doc: "Output chunk files"
    outputBinding:
      glob: $(inputs.out_prefix)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs_read_utils_split_reads.out
