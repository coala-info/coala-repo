cwlVersion: v1.2
class: CommandLineTool
baseCommand: bam2fasta
label: pbtk_bam2fasta
doc: "Converts multiple BAM and/or DataSet files into into gzipped FASTA file(s).\n
  \nTool homepage: https://github.com/PacificBiosciences/pbbioconda"
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: Input file(s).
    inputBinding:
      position: 1
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Gzip compression level [1-9]
    inputBinding:
      position: 102
      prefix: -c
  - id: no_compress
    type:
      - 'null'
      - boolean
    doc: Do not compress. In this case, we will not add .gz, and we ignore any -c
      setting.
    inputBinding:
      position: 102
      prefix: -u
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use, 0 means autodetection.
    inputBinding:
      position: 102
      prefix: --num-threads
  - id: seqid_prefix
    type:
      - 'null'
      - string
    doc: Prefix for sequence IDs in headers
    inputBinding:
      position: 102
      prefix: --seqid-prefix
  - id: split_barcodes
    type:
      - 'null'
      - boolean
    doc: Split output into multiple FASTA files, by barcode pairs.
    inputBinding:
      position: 102
      prefix: --split-barcodes
  - id: with_biosample_prefix
    type:
      - 'null'
      - boolean
    doc: Add BioSample to prefix for sequence IDs in headers
    inputBinding:
      position: 102
      prefix: --with-biosample-prefix
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: Prefix of output filenames, '-' implies streaming. Streaming not supported
      with compression nor with split_barcodes
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbtk:3.5.0--h9ee0642_0
