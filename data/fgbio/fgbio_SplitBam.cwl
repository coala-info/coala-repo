cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgbio
label: fgbio_SplitBam
doc: "Splits a BAM into multiple BAMs, one per-read group (or library).\n\nThe resulting\
  \ BAMs will be named '<output-prefix>.<read-group-id>.bam', or '<output-prefix>.<library-name>.bam'\
  \ when\nsplitting by the library. All reads without a read group, or without a library\
  \ when splitting by library, will be\nwritten to '<output-prefix>.unknown.bam'.\
  \ If no such reads exist, then no such file will exist.\n\nBy default, async writing\
  \ of BAM files is controlled by the '--async-io' common tool option to increase\
  \ performance. If\nthe input BAM has significantly more read groups (or libraries)\
  \ than your system has CPUs it is recommended to disable\nthis feature for this\
  \ tool using '--no-async-writing'. Asynchronous reading is not affected.\n\nTool\
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
  - id: input_bam
    type: File
    doc: Input SAM or BAM file.
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
  - id: no_async_writing
    type:
      - 'null'
      - boolean
    doc: 'Do not write the records asynchronously. Use this to reduce memory usage
      when many read groups/libraries are present. [Default: false].'
    inputBinding:
      position: 101
      prefix: --no-async-writing
      separate: false
      valueFrom: $("=" + self)
  - id: output_prefix
    type: string
    doc: Output prefix for all SAM or BAM files (ex. output/sample-name).
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
  - id: split_by
    type:
      - 'null'
      - string
    doc: 'Split by library instead of read group [Default: ReadGroup]. Options: Library,
      ReadGroup.'
    inputBinding:
      position: 101
      prefix: --split-by
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: Directory to use for temporary files.
    inputBinding:
      position: 1
      prefix: --tmp-dir
  - id: unknown
    type:
      - 'null'
      - string
    doc: 'The name to use for the unknown file [Default: unknown].'
    inputBinding:
      position: 101
      prefix: --unknown
arguments:
  - position: 50
    valueFrom: SplitBam
outputs:
  - id: output_bams
    type:
      type: array
      items: File
    doc: One BAM per read group (or library), named <output-prefix>.<id>.bam.
    outputBinding:
      glob: $(inputs.output_prefix).*.bam
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
requirements:
  - class: InlineJavascriptRequirement
