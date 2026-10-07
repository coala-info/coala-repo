cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chado
  - insert
  - organism
label: chado-tools_insert_organism
doc: "insert an organism into the CHADO database\n\nTool homepage: https://github.com/sanger-pathogens/chado-tools/"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "verbose mode"
    inputBinding:
      position: 101
      prefix: --verbose
  - id: config
    type:
      - 'null'
      - File
    doc: "YAML file containing connection details"
    inputBinding:
      position: 101
      prefix: --config
  - id: use_password
    type:
      - 'null'
      - boolean
    doc: "connect with password (default: no password)"
    inputBinding:
      position: 101
      prefix: --use_password
  - id: dbname
    type: string
    doc: "name of the database"
    inputBinding:
      position: 1
  - id: genus
    type: string
    doc: "genus of the organism"
    inputBinding:
      position: 101
      prefix: --genus
  - id: species
    type: string
    doc: "species of the organism"
    inputBinding:
      position: 101
      prefix: --species
  - id: infraspecific_name
    type:
      - 'null'
      - string
    doc: "infraspecific name (strain) of the organism"
    inputBinding:
      position: 101
      prefix: --infraspecific_name
  - id: abbreviation
    type: string
    doc: "abbreviation/short name of the organism"
    inputBinding:
      position: 101
      prefix: --abbreviation
  - id: common_name
    type:
      - 'null'
      - string
    doc: "common name of the organism (default: use abbreviation, if provided)"
    inputBinding:
      position: 101
      prefix: --common_name
  - id: comment
    type:
      - 'null'
      - string
    doc: "comment"
    inputBinding:
      position: 101
      prefix: --comment
  - id: genome_version
    type:
      - 'null'
      - string
    doc: "version number of the genome"
    inputBinding:
      position: 101
      prefix: --genome_version
  - id: taxon_id
    type:
      - 'null'
      - string
    doc: "NCBI taxon ID"
    inputBinding:
      position: 101
      prefix: --taxon_id
  - id: wikidata_id
    type:
      - 'null'
      - string
    doc: "ID of the organism on Wikidata"
    inputBinding:
      position: 101
      prefix: --wikidata_id
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chado-tools:0.2.15--py_0
stdout: chado-tools_insert_organism.out
