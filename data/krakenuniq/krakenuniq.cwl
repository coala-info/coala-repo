cwlVersion: v1.2
class: CommandLineTool
baseCommand: krakenuniq
label: krakenuniq
doc: "KrakenUniq is a metagenomics classifier that assigns taxonomic labels to short
  DNA reads and uses unique k-mer counts to reduce false positives.\n\nTool homepage:
  https://github.com/fbreitwieser/krakenuniq"
inputs:
  - id: sequences
    type:
      type: array
      items: File
    doc: Input sequence files
    inputBinding:
      position: 1
  - id: bzip2_compressed
    type:
      - 'null'
      - boolean
    doc: Input files are compressed with bzip2
    inputBinding:
      position: 102
      prefix: --bzip2-compressed
  - id: db
    type: Directory
    doc: Name of KrakenUniq database
    inputBinding:
      position: 102
      prefix: --db
  - id: fasta_input
    type:
      - 'null'
      - boolean
    doc: Input is FASTA format
    inputBinding:
      position: 102
      prefix: --fasta-input
  - id: fastq_input
    type:
      - 'null'
      - boolean
    doc: Input is FASTQ format
    inputBinding:
      position: 102
      prefix: --fastq-input
  - id: gzip_compressed
    type:
      - 'null'
      - boolean
    doc: Input files are compressed with gzip
    inputBinding:
      position: 102
      prefix: --gzip-compressed
  - id: paired
    type:
      - 'null'
      - boolean
    doc: The two filenames provided are paired-end reads
    inputBinding:
      position: 102
      prefix: --paired
  - id: preload
    type:
      - 'null'
      - boolean
    doc: Loads DB into memory before classification
    inputBinding:
      position: 102
      prefix: --preload
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Print output to FILE
    outputBinding:
      glob: $(inputs.output)
  - id: report_file
    type:
      - 'null'
      - File
    doc: Print a report with aggregate counts/clade to FILE
    outputBinding:
      glob: $(inputs.report_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krakenuniq:1.0.4--pl5321h668145b_4
