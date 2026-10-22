cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svdb
  - --build
label: svdb_build
doc: "Create an SVDB structural variant database (SQLite) from VCF files\n\nTool homepage:
  https://github.com/J35P312/SVDB"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Create a db using the specified vcf files (cannot be used with --folder).
    inputBinding:
      position: 101
      prefix: --files
  - id: folder
    type:
      - 'null'
      - string
    doc: Create a db using all the vcf files in the folders.
    inputBinding:
      position: 101
      prefix: --folder
  - id: passonly
    type:
      - 'null'
      - boolean
    doc: Remove filtered variants (i.e anything not labeled "PASS" or ".").
    inputBinding:
      position: 101
      prefix: --passonly
  - id: prefix
    type:
      - 'null'
      - string
    doc: The prefix of the output file, default = SVDB.
    inputBinding:
      position: 101
      prefix: --prefix
outputs:
  - id: database
    type:
      - 'null'
      - type: array
        items: File
    doc: The SVDB database (prefix.db).
    outputBinding:
      glob: '$(inputs.prefix ? inputs.prefix : "SVDB")*.db'
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svdb:2.8.4--py311h7c5c6c8_0
stdout: svdb_build.out
