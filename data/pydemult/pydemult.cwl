cwlVersion: v1.2
class: CommandLineTool
baseCommand: pydemult
label: pydemult
doc: "Demultiplexing of fastq files\n\nTool homepage: https://github.com/jenzopr/pydemult"
inputs:
  - id: barcode_column
    type:
      - 'null'
      - string
    doc: Name of the column containing barcodes
    default: Barcode
    inputBinding:
      position: 101
      prefix: --barcode-column
  - id: barcode_regex
    type:
      - 'null'
      - string
    doc: Regular expression to parse cell barcode (CB) and UMIs (UMI) from read 
      names
    inputBinding:
      position: 101
      prefix: --barcode-regex
  - id: buffer_size
    type:
      - 'null'
      - int
    doc: Buffer size for the FASTQ reader (in Bytes). Must be large enough to 
      contain the largest entry.
    default: 4000000
    inputBinding:
      position: 101
      prefix: --buffer-size
  - id: column_separator
    type:
      - 'null'
      - string
    doc: Separator that is used in samplesheet
    inputBinding:
      position: 101
      prefix: --column-separator
  - id: debug
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --debug
  - id: edit_alphabet
    type:
      - 'null'
      - string
    doc: The alphabet that is used to created edited barcodes
    default: ACGTN
    inputBinding:
      position: 101
      prefix: --edit-alphabet
  - id: edit_distance
    type:
      - 'null'
      - int
    doc: Maximum allowed edit distance for barcodes
    default: 1
    inputBinding:
      position: 101
      prefix: --edit-distance
  - id: fastq
    type: File
    doc: FASTQ file for demultiplexing.
    inputBinding:
      position: 101
      prefix: --fastq
  - id: keep_empty
    type:
      - 'null'
      - boolean
    doc: Keep empty sequences in demultiplexed output files.
    inputBinding:
      position: 101
      prefix: --keep-empty
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory to write individual fastq files to.
    default: fastq
    inputBinding:
      position: 101
      prefix: --output
  - id: output_file_suffix
    type:
      - 'null'
      - string
    doc: A suffix to append to individual fastq files.
    default: .fastq.gz
    inputBinding:
      position: 101
      prefix: --output-file-suffix
  - id: sample_column
    type:
      - 'null'
      - string
    doc: Name of the column containing sample names
    default: Sample
    inputBinding:
      position: 101
      prefix: --sample-column
  - id: samplesheet
    type: File
    doc: Samplesheet containing barcodes and samplenames
    inputBinding:
      position: 101
      prefix: --samplesheet
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for multiprocessing.
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: write_unmatched
    type:
      - 'null'
      - boolean
    doc: Write reads with unmatched barcodes into unmatched.fastq.gz
    inputBinding:
      position: 101
      prefix: --write-unmatched
  - id: writer_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for writing
    default: 2
    inputBinding:
      position: 101
      prefix: --writer-threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pydemult:0.6--py_0
stdout: pydemult.out
