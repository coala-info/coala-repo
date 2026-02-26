cwlVersion: v1.2
class: CommandLineTool
baseCommand: augur merge
label: augur_merge
doc: "Merge two or more datasets into one. Datasets can consist of metadata and/or
  sequence files. If both are provided, the order and file contents are used independently.\n\
  \nTool homepage: https://github.com/nextstrain/augur"
inputs:
  - id: metadata
    type:
      - 'null'
      - type: array
        items: string
    doc: Metadata table names and file paths. Names are arbitrary monikers used 
      solely for referring to the associated input file in other arguments and 
      in output column names. Paths must be to seekable files, not unseekable 
      streams. Compressed files are supported.
    inputBinding:
      position: 101
      prefix: --metadata
  - id: metadata_delimiters
    type:
      - 'null'
      - type: array
        items: string
    doc: Possible field delimiters to use for reading metadata tables, 
      considered in the order given. Delimiters will be considered for all 
      metadata tables by default. Table-specific delimiters may be given using 
      the same names assigned in --metadata. Only one delimiter will be inferred
      for each table.
    default: ", $'\t'"
    inputBinding:
      position: 101
      prefix: --metadata-delimiters
  - id: metadata_id_columns
    type:
      - 'null'
      - type: array
        items: string
    doc: Possible metadata column names containing identifiers, considered in 
      the order given. Columns will be considered for all metadata tables by 
      default. Table-specific column names may be given using the same names 
      assigned in --metadata. Only one ID column will be inferred for each 
      table.
    default: strain name
    inputBinding:
      position: 101
      prefix: --metadata-id-columns
  - id: no_source_columns
    type:
      - 'null'
      - boolean
    doc: Suppress generated columns (described above) identifying the source of 
      each row's data. This is the default behaviour, but it may be made 
      explicit or used to override a previous --source-columns.
    inputBinding:
      position: 101
      prefix: --no-source-columns
  - id: nthreads
    type:
      - 'null'
      - int
    doc: Number of CPUs/cores/threads/jobs to utilize at once.
    default: 1
    inputBinding:
      position: 101
      prefix: --nthreads
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress informational and warning messages normally written to stderr.
    default: disabled
    inputBinding:
      position: 101
      prefix: --quiet
  - id: sequences
    type:
      - 'null'
      - type: array
        items: File
    doc: Sequence files in FASTA format. Compressed files are supported.
    inputBinding:
      position: 101
      prefix: --sequences
  - id: skip_input_sequences_validation
    type:
      - 'null'
      - boolean
    doc: Skip validation of --sequences (checking for no duplicates) to improve 
      run time. Note that this may result in unexpected behavior in cases where 
      validation would fail.
    default: false
    inputBinding:
      position: 101
      prefix: --skip-input-sequences-validation
  - id: source_columns
    type:
      - 'null'
      - string
    doc: Template with which to generate names for the columns (described above)
      identifying the source of each row's data. Must contain a literal 
      placeholder, {NAME}, which stands in for the metadata table names assigned
      in --metadata.
    default: disabled
    inputBinding:
      position: 101
      prefix: --source-columns
outputs:
  - id: output_metadata
    type:
      - 'null'
      - File
    doc: Merged metadata as TSV. Compressed files are supported.
    outputBinding:
      glob: $(inputs.output_metadata)
  - id: output_sequences
    type:
      - 'null'
      - File
    doc: Merged sequences as FASTA. Compressed files are supported.
    outputBinding:
      glob: $(inputs.output_sequences)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
