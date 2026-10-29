cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgbio
label: fgbio_CopyUmiFromReadName
doc: "Copies the UMI at the end of the BAM's read name to the RX tag.\n\nThe read\
  \ name is split on ':' characters with the last field assumed to be the UMI sequence.\
  \ The UMI will be copied to\nthe 'RX' tag as per the SAM specification. If any read\
  \ does not have a UMI composed of valid bases (ACGTN), the program\nwill report\
  \ the error and fail.\n\nIf a read name contains multiple UMIs they may be delimited\
  \ (typically by a hyphen ('-') or plus ('+')). The\n'--umi-delimiter' option specifies\
  \ the delimiter on which to split. The resulting UMI in the 'RX' tag will always\
  \ be\nhyphen delimited.\n\nSome tools (e.g. BCL Convert) may reverse-complement\
  \ UMIs on R2 and add an 'r' prefix to indicate that the sequence has\nbeen reverse-complemented.\
  \ By default, the 'r' prefix is removed and the sequence is reverse-complemented\
  \ back to the\nforward orientation. The '--override-reverse-complement-umis' disables\
  \ the latter behavior, such that the 'r' prefix is\nremoved but the UMI sequence\
  \ is left as reverse-complemented.\n\nTool homepage: https://github.com/fulcrumgenomics/fgbio"
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
  - id: field_delimiter
    type:
      - 'null'
      - string
    doc: 'Delimiter between the read name and UMI. [Default: :].'
    inputBinding:
      position: 101
      prefix: --field-delimiter
  - id: input_bam
    type: File
    doc: The input BAM file.
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
    doc: The output BAM file.
    inputBinding:
      position: 101
      prefix: --output
  - id: override_reverse_complement_umis
    type:
      - 'null'
      - boolean
    doc: 'Do not reverse-complement UMIs prefixed with ''r''. [Default: false].'
    inputBinding:
      position: 101
      prefix: --override-reverse-complement-umis
      separate: false
      valueFrom: $("=" + self)
  - id: remove_umi
    type:
      - 'null'
      - boolean
    doc: 'Remove the UMI from the read name. [Default: false].'
    inputBinding:
      position: 101
      prefix: --remove-umi
      separate: false
      valueFrom: $("=" + self)
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
  - id: umi_delimiter
    type:
      - 'null'
      - string
    doc: 'Delimiter between UMI sequences. [Default: +].'
    inputBinding:
      position: 101
      prefix: --umi-delimiter
arguments:
  - position: 50
    valueFrom: CopyUmiFromReadName
outputs:
  - id: output_bam_out
    type: File
    doc: The output BAM file.
    outputBinding:
      glob: $(inputs.output_bam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
requirements:
  - class: InlineJavascriptRequirement
