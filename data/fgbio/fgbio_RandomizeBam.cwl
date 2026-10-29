cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgbio
label: fgbio_RandomizeBam
doc: "Randomizes the order of reads in a SAM or BAM file. Randomization is done by\
  \ sorting on a hash of the 'queryname' (and\nbases and quals if not query-grouping).\
  \ By default reads with the same query name are grouped together in the output\n\
  file; this can be turned off by specifying --query-group=false.\n\nTool homepage:\
  \ https://github.com/fulcrumgenomics/fgbio"
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
  - id: input_bam
    type: File
    doc: 'The input SAM or BAM file. [Default: /dev/stdin].'
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
    doc: 'The output SAM or BAM file. [Default: /dev/stdout].'
    inputBinding:
      position: 101
      prefix: --output
  - id: query_group
    type:
      - 'null'
      - boolean
    doc: 'Group together reads by queryname. [Default: true].'
    inputBinding:
      position: 101
      prefix: --query-group
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
  - id: seed
    type:
      - 'null'
      - int
    doc: 'Random seed. [Default: 42].'
    inputBinding:
      position: 101
      prefix: --seed
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
    valueFrom: RandomizeBam
outputs:
  - id: output_bam_out
    type: File
    doc: The output SAM or BAM file.
    outputBinding:
      glob: $(inputs.output_bam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_bam)
        writable: true
