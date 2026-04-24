cwlVersion: v1.2
class: CommandLineTool
baseCommand: bam2fastx
label: bam2fastx
doc: "Convert PacBio BAM files into gzipped fasta and fastq files.\n\nTool homepage:
  https://github.com/PacificBiosciences/bam2fastx"
inputs:
  - id: input_file
    type: File
    doc: Input BAM file (e.g., .subreads.bam or .ccs.bam)
    inputBinding:
      position: 1
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Compression level [1-9]
    inputBinding:
      position: 102
      prefix: -c
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 102
      prefix: --num-threads
  - id: pbi
    type:
      - 'null'
      - boolean
    doc: Generate PacBio Index (.pbi) file
    inputBinding:
      position: 102
      prefix: --pbi
  - id: split_barcodes
    type:
      - 'null'
      - boolean
    doc: Split output files by barcode
    inputBinding:
      position: 102
      prefix: --split-barcodes
  - id: uncompressed
    type:
      - 'null'
      - boolean
    doc: Output uncompressed files
    inputBinding:
      position: 102
      prefix: -u
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: Prefix for output fasta/fastq files
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bam2fastx:3.0.0--h9ee0642_0
