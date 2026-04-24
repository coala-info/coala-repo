cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fgbio
  - HardMaskFasta
label: fgbio_HardMaskFasta
doc: "Converts soft-masked sequence to hard-masked in a FASTA file. All lower case
  bases are converted to Ns, all other bases are left unchanged. Line lengths are
  also standardized to allow easy indexing with 'samtools faidx'\n\nTool homepage:
  https://github.com/fulcrumgenomics/fgbio"
inputs:
  - id: async_io
    type:
      - 'null'
      - boolean
    doc: Use asynchronous I/O where possible, e.g. for SAM and BAM files.
    inputBinding:
      position: 101
      prefix: --async-io
  - id: compression
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
  - id: input_fasta
    type: File
    doc: Input FASTA file.
    inputBinding:
      position: 101
      prefix: --input
  - id: line_length
    type:
      - 'null'
      - int
    doc: Line length or sequence lines.
    inputBinding:
      position: 101
      prefix: --line-length
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Minimum severity log-level to emit. Options: Debug, Info, Warning, Error,
      Fatal.'
    inputBinding:
      position: 101
      prefix: --log-level
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
outputs:
  - id: output_fasta
    type:
      - 'null'
      - File
    doc: Output FASTA file.
    outputBinding:
      glob: $(inputs.output_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
