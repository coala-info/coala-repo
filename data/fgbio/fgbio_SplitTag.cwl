cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgbio
label: fgbio_SplitTag
doc: "Splits an optional tag in a SAM or BAM into multiple optional tags.\n\nTool\
  \ homepage: https://github.com/fulcrumgenomics/fgbio"
inputs:
  - id: async_io
    type:
      - 'null'
      - boolean
    doc: Use asynchronous I/O where possible, e.g. for SAM and BAM files.
    inputBinding:
      position: 1
      prefix: --async-io
      separate: false
      valueFrom: $("=" + self)
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
  - id: delimiter
    type:
      - 'null'
      - string
    doc: 'The delimiter used to split the string. [Default: -].'
    inputBinding:
      position: 101
      prefix: --delimiter=
      separate: false
  - id: input_bam
    type: File
    doc: Input SAM or BAM.
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
  - id: output_bam
    type: string
    doc: Output SAM or BAM.
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
  - id: tag_to_split
    type: string
    doc: Tag to split.
    inputBinding:
      position: 101
      prefix: --tag-to-split
  - id: tags_to_output
    type: string[]
    doc: Tag(s) to output. There should be one per produced token.
    inputBinding:
      position: 101
      prefix: --tags-to-output
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
    valueFrom: SplitTag
outputs:
  - id: output_bam_out
    type: File
    doc: Output SAM or BAM.
    outputBinding:
      glob: $(inputs.output_bam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
requirements:
  - class: InlineJavascriptRequirement
