cwlVersion: v1.2
class: CommandLineTool
baseCommand: gbsx
label: gbsx
doc: "GBSX (Genotype-by-Sequencing Barcode Demultiplexer) is a tool for demultiplexing
  and quality control of GBS data. Note: The provided input text was a Docker system
  error ('no space left on device') and did not contain the actual help documentation.
  The following structure represents the primary 'demultiplexer' utility of GBSX based
  on standard tool documentation.\n\nTool homepage: https://github.com/GenomicsCoreLeuven/GBSX"
inputs:
  - id: barcode_file
    type: File
    doc: Barcode file containing sample information
    inputBinding:
      position: 101
      prefix: -b
  - id: enzyme
    type: string
    doc: Restriction enzyme used (e.g., ApeKI, MseI)
    inputBinding:
      position: 101
      prefix: -i
  - id: forward_read
    type: File
    doc: Forward fastq file (gzipped or uncompressed)
    inputBinding:
      position: 101
      prefix: -f1
  - id: gzip_output
    type:
      - 'null'
      - boolean
    doc: Compress output fastq files using gzip
    inputBinding:
      position: 101
      prefix: -gzip
  - id: mismatches
    type:
      - 'null'
      - int
    doc: Number of allowed mismatches in the barcode
    default: 1
    inputBinding:
      position: 101
      prefix: -m
  - id: reverse_read
    type:
      - 'null'
      - File
    doc: Reverse fastq file (gzipped or uncompressed)
    inputBinding:
      position: 101
      prefix: -f2
outputs:
  - id: output_directory
    type: Directory
    doc: Output directory for demultiplexed files
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gbsx:1.3--0
