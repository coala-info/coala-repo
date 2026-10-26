cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf2db.py
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
    type: string
    inputBinding:
      position: 3
  - id: a_ok
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --a-ok
    doc: list of info names to include even with Number=A (will error if they 
      have > 1 value
    inputBinding:
      position: 104
  - id: expand
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --expand
    doc: sample columns to expand into their own tables
    inputBinding:
      position: 104
  - id: impacts_field
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --impacts-field
    doc: this field should be propagated to the variant_impacts table. by 
      default, only CSQ/EFF/ANN fields are added. the field can be suffixed with
      a type of ':i' or ':f' to indicate int or float to override the default of
      string. e.g. AF:f
    inputBinding:
      position: 104
  - id: info_exclude
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --info-exclude
          separate: true
    doc: don't save this field to the database. May be specified multiple times.
    inputBinding:
      position: 104
  - id: legacy_compression
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 104
      prefix: --legacy-compression
outputs:
  - id: database
    type: File
    doc: The gemini compatible database file that was created.
    outputBinding:
      glob: $(inputs.database_file)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf2db:2020.02.24--pl5321hdfd78af_3
stdout: vcf2db_vcf2db.py.out
