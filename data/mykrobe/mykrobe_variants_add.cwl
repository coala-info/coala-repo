cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mykrobe
  - variants
  - add
label: mykrobe_variants_add
doc: "Adds a set of variants to the database (a MongoDB server is required)\n\nTool homepage: https://github.com/Mykrobe-tools/mykrobe"
inputs:
  - id: vcf
    type: File
    doc: a vcf file
    inputBinding:
      position: 2
  - id: reference_set
    type: string
    doc: reference set
    inputBinding:
      position: 3
  - id: db_name
    type:
      - 'null'
      - string
    doc: db_name
    inputBinding:
      position: 1
      prefix: --db_name
  - id: db_uri
    type:
      - 'null'
      - string
    doc: 'e.g.: mongodb://admin:qwerty@localhost/db_name'
    inputBinding:
      position: 1
      prefix: --db_uri
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force override any skeleton files
    inputBinding:
      position: 1
      prefix: --force
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Only output warnings/errors to stderr
    inputBinding:
      position: 1
      prefix: --quiet
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Output debugging information to stderr
    inputBinding:
      position: 1
      prefix: --debug
  - id: method
    type:
      - 'null'
      - string
    doc: variant caller method (e.g. CORTEX)
    inputBinding:
      position: 1
      prefix: --method
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mykrobe:0.13.0--py38h59a8061_3
stdout: mykrobe_variants_add.out
