cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastafunk
  - subsample
label: fastafunk_subsample
doc: "Subsample FASTA files based on metadata.\n\nTool homepage: https://github.com/cov-ert/fastafunk"
inputs:
  - id: exclude_uk
    type:
      - 'null'
      - boolean
    doc: Includes all UK samples in subsample, and additionally keeps the target
      number of non-UK samples per group
    inputBinding:
      position: 101
      prefix: --exclude-uk
  - id: group_column
    type:
      type: array
      items: string
    doc: Column(s) in the metadata file to define groupings
    inputBinding:
      position: 101
      prefix: --group-column
  - id: in_fasta
    type:
      - 'null'
      - type: array
        items: File
    doc: One or more FASTA files of sequences (else reads from stdin)
    inputBinding:
      position: 101
      prefix: --in-fasta
  - id: in_metadata
    type:
      type: array
      items: File
    doc: One or more CSV or TSV tables of metadata
    inputBinding:
      position: 101
      prefix: --in-metadata
  - id: index_column
    type: string
    doc: Column in the metadata file to use to match to the sequence
    inputBinding:
      position: 101
      prefix: --index-column
  - id: index_field
    type:
      - 'null'
      - type: array
        items: string
    doc: Field(s) in the fasta header to match the metadata (else matches column
      names)
    inputBinding:
      position: 101
      prefix: --index-field
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file to use (otherwise uses stdout, or stderr if out-fasta to 
      stdout)
    inputBinding:
      position: 101
      prefix: --log-file
  - id: low_memory
    type:
      - 'null'
      - boolean
    doc: Assumes no duplicate sequences within a FASTA so can use SeqIO index
    inputBinding:
      position: 101
      prefix: --low-memory
  - id: sample_size
    type:
      - 'null'
      - int
    doc: The number of samples per group to select if not specified by target 
      file
    inputBinding:
      position: 101
      prefix: --sample-size
  - id: select_by_max_column
    type:
      - 'null'
      - string
    doc: Column in the metadata file maximize over when subsetting
    inputBinding:
      position: 101
      prefix: --select-by-max-column
  - id: select_by_min_column
    type:
      - 'null'
      - string
    doc: Column in the metadata file minimize over when subsetting
    inputBinding:
      position: 101
      prefix: --select-by-min-column
  - id: target_file
    type:
      - 'null'
      - File
    doc: CSV file of target numbers per group e.g. an edited version of the 
      count output
    inputBinding:
      position: 101
      prefix: --target-file
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Run with high verbosity (debug level logging)
    inputBinding:
      position: 101
      prefix: --verbose
  - id: where_field
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional matches to header fields
    inputBinding:
      position: 101
      prefix: --where-field
outputs:
  - id: out_fasta
    type:
      - 'null'
      - File
    doc: A FASTA file (else writes to stdout)
    outputBinding:
      glob: $(inputs.out_fasta)
  - id: out_metadata
    type:
      - 'null'
      - File
    doc: A metadata file
    outputBinding:
      glob: $(inputs.out_metadata)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastafunk:0.1.2--pyh5e36f6f_0
