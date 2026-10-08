cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastafunk
  - subsample
label: fastafunk_subsample
doc: "Subsamples a fasta based on groups defined by a metadata file\n\nTool homepage: https://github.com/cov-ert/fastafunk"
inputs:
  - id: in_fasta
    type: ['null', {type: array, items: File}]
    doc: "One or more FASTA files of sequences (else reads from stdin)"
    inputBinding:
      position: 101
      prefix: --in-fasta
  - id: in_metadata
    type: {type: array, items: File}
    doc: "One or more CSV or TSV tables of metadata"
    inputBinding:
      position: 101
      prefix: --in-metadata
  - id: index_field
    type: ['null', {type: array, items: string}]
    doc: "Field(s) in the fasta header to match the metadata (else matches column names)"
    inputBinding:
      position: 101
      prefix: --index-field
  - id: index_column
    type: string
    doc: "Column in the metadata file to use to match to the sequence"
    inputBinding:
      position: 101
      prefix: --index-column
  - id: group_column
    type: {type: array, items: string}
    doc: "Column(s) in the metadata file to define groupings"
    inputBinding:
      position: 101
      prefix: --group-column
  - id: where_field
    type: ['null', string]
    doc: "Additional matches to header fields, as <field>=<regex>"
    inputBinding:
      position: 101
      prefix: --where-field
  - id: out_fasta_path
    type: ['null', string]
    doc: "A FASTA file (else writes to stdout)"
    inputBinding:
      position: 101
      prefix: --out-fasta
  - id: out_metadata_path
    type: ['null', string]
    doc: "A metadata file"
    inputBinding:
      position: 101
      prefix: --out-metadata
  - id: target_file
    type: ['null', File]
    doc: "CSV file of target numbers per group e.g. an edited version of the count output"
    inputBinding:
      position: 101
      prefix: --target-file
  - id: select_by_max_column
    type: ['null', string]
    doc: "Column in the metadata file maximize over when subsetting"
    inputBinding:
      position: 101
      prefix: --select-by-max-column
  - id: select_by_min_column
    type: ['null', string]
    doc: "Column in the metadata file minimize over when subsetting"
    inputBinding:
      position: 101
      prefix: --select-by-min-column
  - id: sample_size
    type: ['null', int]
    doc: "The number of samples per group to select if not specified by target file"
    inputBinding:
      position: 101
      prefix: --sample-size
  - id: exclude_uk
    type: ['null', boolean]
    doc: "Includes all UK samples in subsample, and additionally keeps the target number of non-UK samples per group"
    inputBinding:
      position: 101
      prefix: --exclude-uk
  - id: low_memory
    type: ['null', boolean]
    doc: "Assumes no duplicate sequences within a FASTA so can use SeqIO index"
    inputBinding:
      position: 101
      prefix: --low-memory
  - id: log_file_path
    type: ['null', string]
    doc: "Log file to use (otherwise uses stdout, or stderr if out-fasta to stdout)"
    inputBinding:
      position: 101
      prefix: --log-file
  - id: verbose
    type: ['null', boolean]
    doc: "Run with high verbosity (debug level logging)"
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout_output
    type: stdout
    doc: Standard output (FASTA or table when no output file is given, and log messages).
  - id: out_fasta
    type: ['null', File]
    doc: "A FASTA file (else writes to stdout)"
    outputBinding:
      glob: $(inputs.out_fasta_path)
  - id: out_metadata
    type: ['null', File]
    doc: "A metadata file"
    outputBinding:
      glob: $(inputs.out_metadata_path)
  - id: log_file
    type: ['null', File]
    doc: Log file.
    outputBinding:
      glob: $(inputs.log_file_path)
requirements:
  - class: InlineJavascriptRequirement
stdout: fastafunk_subsample.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastafunk:0.1.2--pyh5e36f6f_0
