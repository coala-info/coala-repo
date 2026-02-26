cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fgbio
  - UpdateIntervalListContigNames
label: fgbio_UpdateIntervalListContigNames
doc: "Updates the sequence names in an Interval List file.\n\nThe name of each sequence
  must match one of the names (including aliases) in the given sequence dictionary.
  The new\nname will be the primary (non-alias) name in the sequence dictionary.\n\
  \nUse '--skip-missing' to ignore intervals where a contig name could not be updated
  (i.e. missing from the sequence\ndictionary).\n\nTool homepage: https://github.com/fulcrumgenomics/fgbio"
inputs:
  - id: async_io
    type:
      - 'null'
      - boolean
    doc: Use asynchronous I/O where possible, e.g. for SAM and BAM files.
    default: false
    inputBinding:
      position: 101
      prefix: --async-io
  - id: compression
    type:
      - 'null'
      - int
    doc: Default GZIP compression level, BAM compression level.
    default: 5
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
  - id: dict
    type: File
    doc: The path to the sequence dictionary with contig aliases.
    inputBinding:
      position: 101
      prefix: --dict
  - id: input
    type: File
    doc: Input interval list.
    inputBinding:
      position: 101
      prefix: --input
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Minimum severity log-level to emit. Options: Debug, Info, Warning, Error,
      Fatal.'
    default: Info
    inputBinding:
      position: 101
      prefix: --log-level
  - id: sam_validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for SAM/BAM reading. Options: STRICT, LENIENT, SILENT.'
    default: SILENT
    inputBinding:
      position: 101
      prefix: --sam-validation-stringency
  - id: skip_missing
    type:
      - 'null'
      - boolean
    doc: Skip contigs in the interval list that are not found in the sequence 
      dictionary.
    default: false
    inputBinding:
      position: 101
      prefix: --skip-missing
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Directory to use for temporary files.
    default: /tmp
    inputBinding:
      position: 101
      prefix: --tmp-dir
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output interval list.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
