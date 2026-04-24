cwlVersion: v1.2
class: CommandLineTool
baseCommand: augur_parse
label: augur_parse
doc: "Parse delimited fields from FASTA sequence names into a TSV and FASTA file.\n\
  \nTool homepage: https://github.com/nextstrain/augur"
inputs:
  - id: fields
    type:
      type: array
      items: string
    doc: fields in fasta header
    inputBinding:
      position: 101
      prefix: --fields
  - id: fix_dates
    type:
      - 'null'
      - string
    doc: attempt to parse non-standard dates and output them in standard 
      YYYY-MM-DD format
    inputBinding:
      position: 101
      prefix: --fix-dates
  - id: output_id_field
    type:
      - 'null'
      - string
    doc: The record field to use as the sequence identifier in the FASTA output.
      If not provided, this will use the first available of ('strain', 'name'). 
      If none of those are available, this will use the first field in the fasta
      header.
    inputBinding:
      position: 101
      prefix: --output-id-field
  - id: prettify_fields
    type:
      - 'null'
      - type: array
        items: string
    doc: apply string prettifying operations (underscores to spaces, 
      capitalization, etc) to specified metadata fields
    inputBinding:
      position: 101
      prefix: --prettify-fields
  - id: separator
    type:
      - 'null'
      - string
    doc: separator of fasta header
    inputBinding:
      position: 101
      prefix: --separator
  - id: sequences
    type: File
    doc: sequences in fasta or VCF format
    inputBinding:
      position: 101
      prefix: --sequences
outputs:
  - id: output_sequences
    type: File
    doc: output sequences file
    outputBinding:
      glob: $(inputs.output_sequences)
  - id: output_metadata
    type: File
    doc: output metadata file
    outputBinding:
      glob: $(inputs.output_metadata)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
