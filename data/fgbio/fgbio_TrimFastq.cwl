cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fgbio
  - TrimFastq
label: fgbio_TrimFastq
doc: "Trims reads in one or more line-matched fastq files to a specific read length.
  The individual fastq files are expected to have the same set of reads, as would
  be the case with an 'r1.fastq' and 'r2.fastq' file for the same sample.\n\nOptionally
  supports dropping of reads across all files when one or more reads is already shorter
  than the desired trim length.\n\nInput and output fastq files may be gzipped.\n\n\
  Tool homepage: https://github.com/fulcrumgenomics/fgbio"
inputs:
  - id: async_io
    type:
      - 'null'
      - boolean
    doc: Use asynchronous I/O where possible, e.g. for SAM and BAM files.
    inputBinding:
      position: 101
      prefix: --async-io
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Default GZIP compression level, BAM compression level.
    inputBinding:
      position: 101
      prefix: --compression
  - id: cram_ref_fasta
    type:
      - 'null'
      - File
    doc: Reference FASTA for CRAM encoding/decoding.
    inputBinding:
      position: 101
      prefix: --cram-ref-fasta
  - id: exclude_short_reads
    type:
      - 'null'
      - boolean
    doc: Exclude reads below the trim length.
    inputBinding:
      position: 101
      prefix: --exclude
  - id: input_fastq
    type:
      type: array
      items: File
    doc: One or more input fastq files.
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
      position: 101
      prefix: --log-level
  - id: output_fastq
    type:
      type: array
      items: File
    doc: A matching number of output fastq files.
    inputBinding:
      position: 101
      prefix: --output
  - id: sam_validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for SAM/BAM reading. Options: STRICT, LENIENT, SILENT.'
    inputBinding:
      position: 101
      prefix: --sam-validation-stringency
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Directory to use for temporary files.
    inputBinding:
      position: 101
      prefix: --tmp-dir
  - id: trim_length
    type:
      type: array
      items: int
    doc: Length to trim reads to (either one per input fastq file, or one for 
      all).
    inputBinding:
      position: 101
      prefix: --length
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
stdout: fgbio_TrimFastq.out
