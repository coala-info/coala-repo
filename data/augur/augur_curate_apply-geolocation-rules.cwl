cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - augur
  - curate
  - apply-geolocation-rules
label: augur_curate_apply-geolocation-rules
doc: "Applies user curated geolocation rules to the geolocation fields. (augur curate)\n\
  \nTool homepage: https://github.com/nextstrain/augur"
inputs:
  - id: region_field
    type:
      - 'null'
      - string
    doc: 'Field that contains regions in NDJSON records. (default: region)'
    inputBinding:
      position: 1
      prefix: --region-field
  - id: country_field
    type:
      - 'null'
      - string
    doc: 'Field that contains countries in NDJSON records. (default: country)'
    inputBinding:
      position: 1
      prefix: --country-field
  - id: division_field
    type:
      - 'null'
      - string
    doc: 'Field that contains divisions in NDJSON records. (default: division)'
    inputBinding:
      position: 1
      prefix: --division-field
  - id: location_field
    type:
      - 'null'
      - string
    doc: 'Field that contains location in NDJSON records. (default: location)'
    inputBinding:
      position: 1
      prefix: --location-field
  - id: geolocation_rules
    type:
      - 'null'
      - File
    doc: 'TSV file of geolocation rules with the format: ''<raw_geolocation><tab><annotated_geolocation>''
      where the raw and annotated geolocations are formatted as ''<region>/<country>/<division>/<location>''.
      If creating a general rule, then the raw field value can be substituted with
      ''*''.Lines starting with ''#'' will be ignored as comments.Trailing ''#'' will
      be ignored as comments. Note that the raw geolocation matching is case-insensitive
      unless the `--case-sensitive` flag is provided. The rules defined in the provided
      file will have precedence over the default rules in <https://git hub.com/nextstrain/augur/blob/33.0.0/augur/data/geoloc
      ation_rules.tsv>. (default: None)'
    inputBinding:
      position: 1
      prefix: --geolocation-rules
  - id: case_sensitive
    type:
      - 'null'
      - boolean
    doc: 'Use case-sensitive matching of raw geolocation fields to geolocation rules.
      (default: False)'
    inputBinding:
      position: 1
      prefix: --case-sensitive
  - id: no_default_rules
    type:
      - 'null'
      - boolean
    doc: 'Do not use Augur''s default geolocation rules. (default: False)'
    inputBinding:
      position: 1
      prefix: --no-default-rules
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
