cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgbio
label: fgbio-minimal_SortFastq
doc: "Sorts a FASTQ file. Sorts the records in a FASTQ file based on the lexicographic
  ordering of their read names. Input and output files can be either uncompressed
  or gzip-compressed.\n\nTool homepage: https://github.com/fulcrumgenomics/fgbio"
inputs:
  - id: async_io
    type:
      - 'null'
      - boolean
    doc: Use asynchronous I/O where possible, e.g. for SAM and BAM files.
    inputBinding:
      position: 1
      prefix: --async-io
  - id: compression
    type:
      - 'null'
      - int
    doc: Default GZIP compression level, BAM compression level.
    inputBinding:
      position: 1
      prefix: --compression
  - id: cram_ref_fasta
    type:
      - 'null'
      - File
    doc: Reference FASTA for CRAM encoding/decoding.
    inputBinding:
      position: 1
      prefix: --cram-ref-fasta
  - id: input_fastq
    type: File
    doc: Input fastq file.
    inputBinding:
      position: 101
      prefix: --input
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Minimum severity log-level to emit. Options: Debug, Info, Warning, Error,
      Fatal.'
    inputBinding:
      position: 1
      prefix: --log-level
  - id: max_records_in_ram
    type:
      - 'null'
      - int
    doc: Maximum records to keep in RAM at one time.
    inputBinding:
      position: 101
      prefix: --max-records-in-ram
  - id: output_fastq
    type: string
    doc: Output fastq file.
    inputBinding:
      position: 101
      prefix: --output
  - id: sam_validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for SAM/BAM reading. Options: STRICT, LENIENT, SILENT.'
    inputBinding:
      position: 1
      prefix: --sam-validation-stringency
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: Directory to use for temporary files.
    inputBinding:
      position: 1
      prefix: --tmp-dir
arguments:
  - position: 50
    valueFrom: SortFastq
outputs:
  - id: output_fastq_out
    type: File
    doc: Output fastq file.
    outputBinding:
      glob: $(inputs.output_fastq)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio-minimal:3.1.1--hdfd78af_0
