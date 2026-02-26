cwlVersion: v1.2
class: CommandLineTool
baseCommand: PROG
label: msp2db
doc: "Convert msp to SQLite or MySQL database\n\nTool homepage: https://github.com/computational-metabolomics/msp2db"
inputs:
  - id: chunk
    type:
      - 'null'
      - string
    doc: Chunks of spectra to parse data (useful to control memory usage)
    inputBinding:
      position: 101
      prefix: --chunk
  - id: db_type
    type:
      - 'null'
      - string
    doc: Database type [mysql, sqlite]
    default: sqlite
    inputBinding:
      position: 101
      prefix: --db_type
  - id: delete_tables
    type:
      - 'null'
      - boolean
    doc: Delete tables
    inputBinding:
      position: 101
      prefix: --delete_tables
  - id: ignore_compound_lookup
    type:
      - 'null'
      - boolean
    doc: ignore searching of compounds for each spectra based on meta 
      information in the MSP file
    inputBinding:
      position: 101
      prefix: --ignore_compound_lookup
  - id: mslevel
    type:
      - 'null'
      - string
    doc: MS level of fragmentation if not detailed in msp file
    inputBinding:
      position: 101
      prefix: --mslevel
  - id: msp_pth
    type: File
    doc: Path to the MSP file (or directory of msp files)
    inputBinding:
      position: 101
      prefix: --msp_pth
  - id: polarity
    type:
      - 'null'
      - string
    doc: Polarity of fragmentation if not detailed in msp file
    inputBinding:
      position: 101
      prefix: --polarity
  - id: schema
    type:
      - 'null'
      - string
    doc: Type of schema used (by default is "mona" msp style but can use 
      "massbank" style
    default: mona
    inputBinding:
      position: 101
      prefix: --schema
  - id: source
    type: string
    doc: Name of data source (e.g. MassBank, LipidBlast)
    inputBinding:
      position: 101
      prefix: --source
outputs:
  - id: out_pth
    type:
      - 'null'
      - File
    doc: File path for SQLite database
    outputBinding:
      glob: $(inputs.out_pth)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msp2db:0.0.9--py_0
