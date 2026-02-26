cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf2db_vcf2db.py
label: vcf2db_vcf2db.py
doc: "Take a VCF and create a gemini compatible database\n\nTool homepage: https://github.com/quinlan-lab/vcf2db"
inputs:
  - id: vcf_file
    type: File
    inputBinding:
      position: 1
  - id: ped_file
    type: File
    inputBinding:
      position: 2
  - id: database_file
    type: File
    inputBinding:
      position: 3
  - id: a_ok
    type:
      - 'null'
      - type: array
        items: string
    doc: list of info names to include even with Number=A (will error if they 
      have > 1 value
    inputBinding:
      position: 104
      prefix: --a-ok
  - id: expand
    type:
      - 'null'
      - type: array
        items: string
    doc: sample columns to expand into their own tables
    inputBinding:
      position: 104
      prefix: --expand
  - id: impacts_field
    type:
      - 'null'
      - string
    doc: this field should be propagated to the variant_impacts table. by 
      default, only CSQ/EFF/ANN fields are added. the field can be suffixed with
      a type of ':i' or ':f' to indicate int or float to override the default of
      string. e.g. AF:f
    inputBinding:
      position: 104
      prefix: --impacts-field
  - id: info_exclude
    type:
      - 'null'
      - type: array
        items: string
    doc: don't save this field to the database. May be specified multiple times.
    inputBinding:
      position: 104
      prefix: --info-exclude
  - id: legacy_compression
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 104
      prefix: --legacy-compression
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf2db:2020.02.24--pl5321hdfd78af_3
stdout: vcf2db_vcf2db.py.out
