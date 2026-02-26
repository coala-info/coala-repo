cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fgbio
  - UpdateFastaContigNames
label: fgbio_UpdateFastaContigNames
doc: "Updates the sequence names in a FASTA.\n\nThe name of each sequence must match
  one of the names (including aliases) in the given sequence dictionary. The new\n\
  name will be the primary (non-alias) name in the sequence dictionary.\n\nBy default,
  the sort order of the contigs will be the same as the input FASTA. Use the '--sort-by-dict'
  option to sort\nby the input sequence dictionary. Furthermore, the sequence dictionary
  may contain more contigs than the input FASTA, \nand they wont be used.\n\nUse the
  '--skip-missing' option to skip contigs in the input FASTA that cannot be renamed
  (i.e. who are not present in\nthe input sequence dictionary); missing contigs will
  not be written to the output FASTA. Finally, use the\n'--default-contigs' option
  to specify an additional FASTA which will be queried to locate contigs not present
  in the\ninput FASTA but present in the sequence dictionary.\n\nTool homepage: https://github.com/fulcrumgenomics/fgbio"
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
  - id: default_contigs
    type:
      - 'null'
      - File
    doc: "Add sequences from this FASTA when contigs in the sequence dictionary are
      missing from\nthe input FASTA."
    inputBinding:
      position: 101
      prefix: --default-contigs
  - id: dict
    type: File
    doc: The path to the sequence dictionary with contig aliases.
    inputBinding:
      position: 101
      prefix: --dict
  - id: input_fasta
    type: File
    doc: Input FASTA.
    inputBinding:
      position: 101
      prefix: --input
  - id: line_length
    type:
      - 'null'
      - int
    doc: Line length or sequence lines.
    default: 100
    inputBinding:
      position: 101
      prefix: --line-length
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
    doc: Skip contigs in the FASTA that are not found in the sequence 
      dictionary.
    default: false
    inputBinding:
      position: 101
      prefix: --skip-missing
  - id: sort_by_dict
    type:
      - 'null'
      - boolean
    doc: Sort the contigs based on the input sequence dictionary.
    default: false
    inputBinding:
      position: 101
      prefix: --sort-by-dict
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
  - id: output_fasta
    type: File
    doc: Output FASTA.
    outputBinding:
      glob: $(inputs.output_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
