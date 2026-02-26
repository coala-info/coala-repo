cwlVersion: v1.2
class: CommandLineTool
baseCommand: enasearch_get_analysis_fields
label: enasearch_get_analysis_fields
doc: "Get analysis fields from ENA.\n\nTool homepage: http://bebatut.fr/enasearch/"
inputs:
  - id: analysis_accession
    type:
      - 'null'
      - boolean
    doc: analysis_accession
    inputBinding:
      position: 101
      prefix: --analysis_accession
  - id: analysis_alias
    type:
      - 'null'
      - boolean
    doc: analysis_alias
    inputBinding:
      position: 101
      prefix: --analysis_alias
  - id: analysis_title
    type:
      - 'null'
      - boolean
    doc: analysis_title
    inputBinding:
      position: 101
      prefix: --analysis_title
  - id: analysis_type
    type:
      - 'null'
      - boolean
    doc: analysis_type
    inputBinding:
      position: 101
      prefix: --analysis_type
  - id: broker_name
    type:
      - 'null'
      - boolean
    doc: broker_name
    inputBinding:
      position: 101
      prefix: --broker_name
  - id: center_name
    type:
      - 'null'
      - boolean
    doc: center_name
    inputBinding:
      position: 101
      prefix: --center_name
  - id: first_public
    type:
      - 'null'
      - boolean
    doc: first_public
    inputBinding:
      position: 101
      prefix: --first_public
  - id: last_updated
    type:
      - 'null'
      - boolean
    doc: last_updated
    inputBinding:
      position: 101
      prefix: --last_updated
  - id: sample_accession
    type:
      - 'null'
      - boolean
    doc: sample_accession
    inputBinding:
      position: 101
      prefix: --sample_accession
  - id: sample_alias
    type:
      - 'null'
      - boolean
    doc: sample_alias
    inputBinding:
      position: 101
      prefix: --sample_alias
  - id: scientific_name
    type:
      - 'null'
      - boolean
    doc: scientific_name
    inputBinding:
      position: 101
      prefix: --scientific_name
  - id: secondary_sample_accession
    type:
      - 'null'
      - boolean
    doc: secondary_sample_accession
    inputBinding:
      position: 101
      prefix: --secondary_sample_accession
  - id: secondary_study_accession
    type:
      - 'null'
      - boolean
    doc: secondary_study_accession
    inputBinding:
      position: 101
      prefix: --secondary_study_accession
  - id: study_accession
    type:
      - 'null'
      - boolean
    doc: study_accession
    inputBinding:
      position: 101
      prefix: --study_accession
  - id: study_alias
    type:
      - 'null'
      - boolean
    doc: study_alias
    inputBinding:
      position: 101
      prefix: --study_alias
  - id: study_title
    type:
      - 'null'
      - boolean
    doc: study_title
    inputBinding:
      position: 101
      prefix: --study_title
  - id: submitted_aspera
    type:
      - 'null'
      - boolean
    doc: submitted_aspera
    inputBinding:
      position: 101
      prefix: --submitted_aspera
  - id: submitted_bytes
    type:
      - 'null'
      - boolean
    doc: submitted_bytes
    inputBinding:
      position: 101
      prefix: --submitted_bytes
  - id: submitted_ftp
    type:
      - 'null'
      - boolean
    doc: submitted_ftp
    inputBinding:
      position: 101
      prefix: --submitted_ftp
  - id: submitted_galaxy
    type:
      - 'null'
      - boolean
    doc: submitted_galaxy
    inputBinding:
      position: 101
      prefix: --submitted_galaxy
  - id: submitted_md5
    type:
      - 'null'
      - boolean
    doc: submitted_md5
    inputBinding:
      position: 101
      prefix: --submitted_md5
  - id: tax_id
    type:
      - 'null'
      - boolean
    doc: tax_id
    inputBinding:
      position: 101
      prefix: --tax_id
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enasearch:0.2.2--py27_0
stdout: enasearch_get_analysis_fields.out
