cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - augur
  - curate
  - abbreviate-authors
label: augur_curate_abbreviate-authors
doc: "Abbreviates a full list of authors to be '<first author> et al.' (augur curate)\n\
  \nTool homepage: https://github.com/nextstrain/augur"
inputs:
  - id: authors_field
    type:
      - 'null'
      - string
    doc: 'The field containing list of authors. (default: authors)'
    inputBinding:
      position: 1
      prefix: --authors-field
  - id: default_value
    type:
      - 'null'
      - string
    doc: 'Default value to use if authors list is empty. (default: ?)'
    inputBinding:
      position: 1
      prefix: --default-value
  - id: abbr_authors_field
    type:
      - 'null'
      - string
    doc: 'The field for the generated abbreviated authors. If not provided, the original
      authors field will be modified. (default: None)'
    inputBinding:
      position: 1
      prefix: --abbr-authors-field
  - id: metadata
    type:
      - 'null'
      - File
    doc: 'Input metadata file. May be plain text (TSV, CSV) or an Excel or OpenOffice
      spreadsheet workbook file. When an Excel or OpenOffice workbook, only the first
      visible worksheet will be read and initial empty rows/columns will be ignored.
      Accepts ''-'' to read plain text from stdin. (default: None)'
    inputBinding:
      position: 1
      prefix: --metadata
  - id: id_column
    type:
      - 'null'
      - string
    doc: 'Name of the metadata column that contains the record identifier for reporting
      duplicate records. Uses the first column of the metadata file if not provided.
      Ignored if also providing a FASTA file input. (default: None)'
    inputBinding:
      position: 1
      prefix: --id-column
  - id: metadata_delimiters
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Delimiters to accept when reading a plain text metadata file. Only one delimiter
      will be inferred. (default: ('','', ''\t''))'
    inputBinding:
      position: 1
      prefix: --metadata-delimiters
  - id: fasta
    type:
      - 'null'
      - File
    doc: 'Plain or gzipped FASTA file. Headers can only contain the sequence id used
      to match a metadata record. Note that an index file will be generated for the
      FASTA file as <filename>.fasta.fxi (default: None)'
    inputBinding:
      position: 1
      prefix: --fasta
  - id: seq_id_column
    type:
      - 'null'
      - string
    doc: 'Name of metadata column that contains the sequence id to match sequences
      in the FASTA file. (default: None)'
    inputBinding:
      position: 1
      prefix: --seq-id-column
  - id: seq_field
    type:
      - 'null'
      - string
    doc: 'The name to use for the sequence field when joining sequences from a FASTA
      file. (default: None)'
    inputBinding:
      position: 1
      prefix: --seq-field
  - id: unmatched_reporting
    type:
      - 'null'
      - type: enum
        symbols:
          - error_first
          - error_all
          - warn
          - silent
    doc: 'How unmatched records from combined metadata/FASTA input should be reported.
      (default: error_first)'
    inputBinding:
      position: 1
      prefix: --unmatched-reporting
  - id: duplicate_reporting
    type:
      - 'null'
      - type: enum
        symbols:
          - error_first
          - error_all
          - warn
          - silent
    doc: 'How should duplicate records be reported. (default: error_first)'
    inputBinding:
      position: 1
      prefix: --duplicate-reporting
  - id: output_metadata
    type:
      - 'null'
      - string
    doc: 'Output metadata TSV file. Accepts ''-'' to output TSV to stdout. (default:
      None)'
    inputBinding:
      position: 1
      prefix: --output-metadata
  - id: output_fasta
    type:
      - 'null'
      - string
    doc: 'Output FASTA file. (default: None)'
    inputBinding:
      position: 1
      prefix: --output-fasta
  - id: output_id_field
    type:
      - 'null'
      - string
    doc: 'The record field to use as the sequence identifier in the FASTA output.
      (default: None)'
    inputBinding:
      position: 1
      prefix: --output-id-field
  - id: output_seq_field
    type:
      - 'null'
      - string
    doc: 'The record field that contains the sequence for the FASTA output. This field
      will be deleted from the metadata output. (default: None)'
    inputBinding:
      position: 1
      prefix: --output-seq-field
  - id: records
    type:
      - 'null'
      - File
    doc: NDJSON records read on standard input when no --metadata/--fasta input is
      given (the default input of augur curate commands).
outputs:
  - id: output_metadata_file
    type:
      - 'null'
      - File
    doc: Output metadata TSV file.
    outputBinding:
      glob: $(inputs.output_metadata)
  - id: output_fasta_file
    type:
      - 'null'
      - File
    doc: Output FASTA file.
    outputBinding:
      glob: $(inputs.output_fasta)
  - id: ndjson
    type: stdout
    doc: NDJSON records written to standard output when no --output-metadata/--output-fasta
      is given.
stdin: '${ return inputs.records ? inputs.records.path : null; }'
stdout: curated_records.ndjson
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '${ return inputs.fasta ? [{"entry": inputs.fasta, "writable": true}]
      : []; }'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
