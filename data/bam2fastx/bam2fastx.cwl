cwlVersion: v1.2
class: CommandLineTool
label: bam2fastx
doc: "Convert PacBio BAM and/or DataSet files into gzipped FASTA (bam2fasta) or FASTQ
  (bam2fastq) files. The package has no bam2fastx command; output_type picks the
  program.\n\nTool homepage: https://github.com/PacificBiosciences/bam2fastx"
inputs:
  - id: output_type
    type:
      type: enum
      symbols:
        - fasta
        - fastq
    default: fastq
    doc: 'Output format: fasta runs bam2fasta, fastq runs bam2fastq'
  - id: input_files
    type:
      type: array
      items: File
    doc: Input BAM and/or DataSet file(s); a BAM needs its .pbi index beside it
    secondaryFiles:
      - pattern: .pbi
        required: false
    inputBinding:
      position: 1
  - id: output_prefix_path
    type: string
    doc: Prefix of output filenames
    inputBinding:
      position: 102
      prefix: --output
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Gzip compression level [1-9] [1]
    inputBinding:
      position: 102
      prefix: -c
  - id: uncompressed
    type:
      - 'null'
      - boolean
    doc: Do not compress. In this case, .gz is not added and -c is ignored.
    inputBinding:
      position: 102
      prefix: -u
  - id: split_barcodes
    type:
      - 'null'
      - boolean
    doc: Split output into multiple files, by barcode pairs.
    inputBinding:
      position: 102
      prefix: --split-barcodes
  - id: seqid_prefix
    type:
      - 'null'
      - string
    doc: Prefix for sequence IDs in headers
    inputBinding:
      position: 102
      prefix: --seqid-prefix
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use, 0 means autodetection. [0]
    inputBinding:
      position: 102
      prefix: --num-threads
arguments:
  - position: 0
    valueFrom: "$(inputs.output_type == 'fasta' ? 'bam2fasta' : 'bam2fastq')"
outputs:
  - id: output_prefix
    type:
      type: array
      items: File
    doc: Output fasta/fastq files
    outputBinding:
      glob: $(inputs.output_prefix_path)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bam2fastx:3.0.0--h9ee0642_0
