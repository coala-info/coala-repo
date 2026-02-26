cwlVersion: v1.2
class: CommandLineTool
baseCommand: augur curate
label: augur_curate
doc: "A suite of commands to help with data curation.\n\nTool homepage: https://github.com/nextstrain/augur"
inputs:
  - id: subcommand
    type: string
    doc: The subcommand to run.
    inputBinding:
      position: 1
  - id: abbreviate_authors
    type:
      - 'null'
      - boolean
    doc: "Abbreviates a full list of authors to be '<first\nauthor> et al.'"
    inputBinding:
      position: 102
      prefix: abbreviate-authors
  - id: apply_geolocation_rules
    type:
      - 'null'
      - boolean
    doc: "Applies user curated geolocation rules to the\ngeolocation fields."
    inputBinding:
      position: 102
      prefix: apply-geolocation-rules
  - id: apply_record_annotations
    type:
      - 'null'
      - boolean
    doc: Applies record annotations to overwrite field values.
    inputBinding:
      position: 102
      prefix: apply-record-annotations
  - id: format_dates
    type:
      - 'null'
      - boolean
    doc: Format date fields to ISO 8601 dates (YYYY-MM-DD).
    inputBinding:
      position: 102
      prefix: format-dates
  - id: normalize_strings
    type:
      - 'null'
      - boolean
    doc: "Normalize strings to a Unicode normalization form and\nstrip leading and
      trailing whitespaces."
    inputBinding:
      position: 102
      prefix: normalize-strings
  - id: parse_genbank_location
    type:
      - 'null'
      - boolean
    doc: "Parses GenBank's location field into 3 separate\nfields: 'country', 'division',
      and 'location'."
    inputBinding:
      position: 102
      prefix: parse-genbank-location
  - id: passthru
    type:
      - 'null'
      - boolean
    doc: "Pass through records without doing any data\ntransformations."
    inputBinding:
      position: 102
      prefix: passthru
  - id: rename
    type:
      - 'null'
      - boolean
    doc: Renames fields / columns of the input data
    inputBinding:
      position: 102
      prefix: rename
  - id: titlecase
    type:
      - 'null'
      - boolean
    doc: Applies titlecase to specified string fields
    inputBinding:
      position: 102
      prefix: titlecase
  - id: transform_strain_name
    type:
      - 'null'
      - boolean
    doc: Verifies strain name pattern in the 'strain' field.
    inputBinding:
      position: 102
      prefix: transform-strain-name
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
stdout: augur_curate.out
