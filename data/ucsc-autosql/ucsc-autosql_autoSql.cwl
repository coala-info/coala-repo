cwlVersion: v1.2
class: CommandLineTool
baseCommand: autoSql
label: ucsc-autosql_autoSql
doc: "create SQL and C code for permanently storing a structure in database and loading
  it back into memory based on a specification file\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: spec_file
    type: File
    doc: Specification file
    inputBinding:
      position: 1
  - id: out_root
    type: string
    doc: Root name for output files (e.g., outRoot.sql, outRoot.c, outRoot.h)
    inputBinding:
      position: 2
  - id: add_bin
    type:
      - 'null'
      - boolean
    doc: Add an initial bin field and index it as (chrom,bin)
    inputBinding:
      position: 103
      prefix: -addBin
  - id: db_link
    type:
      - 'null'
      - boolean
    doc: optionally generates code to execute queries and updates of the table.
    inputBinding:
      position: 103
      prefix: -dbLink
  - id: default_zeros
    type:
      - 'null'
      - boolean
    doc: will put zero and or empty string as default value
    inputBinding:
      position: 103
      prefix: -defaultZeros
  - id: django
    type:
      - 'null'
      - boolean
    doc: generate method to output object as django model Python code
    inputBinding:
      position: 103
      prefix: -django
  - id: json
    type:
      - 'null'
      - boolean
    doc: generate method to output the object in JSON (JavaScript) format.
    inputBinding:
      position: 103
      prefix: -json
  - id: with_null
    type:
      - 'null'
      - boolean
    doc: optionally generates code and .sql to enable applications to accept and
      load data into objects with potential 'missing data' (NULL in SQL) 
      situations.
    inputBinding:
      position: 103
      prefix: -withNull
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-autosql:482--h0b57e2e_0
stdout: ucsc-autosql_autoSql.out
