cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastqsplitter
label: fastqsplitter
doc: "Split a fastq file into multiple parts.\n\nTool homepage: https://github.com/LUMC/fastqsplitter"
inputs:
  - id: compression
    type:
      - 'null'
      - int
    doc: Only applicable when output files have a '.gz' extension. Default=1
    inputBinding:
      position: 101
      prefix: --compression-level
  - id: input
    type: File
    doc: The fastq file to be scattered.
    inputBinding:
      position: 101
      prefix: --input
  - id: threads
    type:
      - 'null'
      - int
    doc: Set the number of compression threads per output file. More threads
      are only useful when using a compression level > 1. Default=1
    inputBinding:
      position: 101
      prefix: --threads-per-file
  - id: cython
    type:
      - 'null'
      - boolean
    doc: Use the cython version of the file splitting algorithm. (default)
    inputBinding:
      position: 101
      prefix: --cython
  - id: python
    type:
      - 'null'
      - boolean
    doc: Use the python version of the file splitting algorithm.
    inputBinding:
      position: 101
      prefix: --python
  - id: output_path
    type:
      type: array
      items: string
      inputBinding:
        prefix: --output
    doc: Scatter over these output files. The reads are distributed over the
      files in turn. The extensions determine which compression algorithm
      will be used. '.gz' for gzip, '.bz2' for bzip2, '.xz' for xz. Other
      extensions will use no compression.
    inputBinding:
      position: 102
outputs:
  - id: output
    type:
      type: array
      items: File
    doc: Output fastq files (can be compressed).
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqsplitter:1.2.0--py310h4b81fae_5
