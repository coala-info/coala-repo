cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - shmlast
  - crbl
label: shmlast_crbl
doc: "Run Conditional Reciprocal Best Hits between the query and database.\n\nTool
  homepage: https://github.com/camillescott/shmlast"
inputs:
  - id: action
    type:
      - 'null'
      - string
    doc: pydoit action. A common alternative is "clean."
    inputBinding:
      position: 101
      prefix: --action
  - id: database
    type: File
    doc: FASTA file with database proteins.
    inputBinding:
      position: 101
      prefix: --database
  - id: evalue_cutoff
    type:
      - 'null'
      - float
    doc: Maximum evalue to accept.
    inputBinding:
      position: 101
      prefix: --evalue-cutoff
  - id: n_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 101
      prefix: --n_threads
  - id: profile
    type:
      - 'null'
      - boolean
    doc: If True, record CPU time.
    inputBinding:
      position: 101
      prefix: --profile
  - id: profile_output
    type:
      - 'null'
      - string
    doc: Filename for profile results.
    inputBinding:
      position: 101
      prefix: --profile-output
  - id: query
    type: File
    doc: FASTA file with query transcriptome.
    inputBinding:
      position: 101
      prefix: --query
  - id: output_path
    type:
      - 'null'
      - string
    doc: CSV output file path
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: File to place the CSV format CRBL hits. By default, 
      QUERY.x.DATABASE.{c}rbl.csv.
    outputBinding:
      glob: $(inputs.output_path)
  - id: default_output
    type:
      - 'null'
      - File
    doc: CSV hits file under its default name (used when no output path is given)
    outputBinding:
      glob: $(inputs.query.basename).x.$(inputs.database.basename).crbl.csv
  - id: profile_results
    type:
      - 'null'
      - File
    doc: Profile results
    outputBinding:
      glob: $(inputs.profile_output)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.query)
        writable: true
      - entry: $(inputs.database)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shmlast:1.6--py_0
