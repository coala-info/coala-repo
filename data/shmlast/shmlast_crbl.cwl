cwlVersion: v1.2
class: CommandLineTool
baseCommand: shmlast crbl
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
      - File
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
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: File to place the CSV format CRBL hits. By default, 
      QUERY.x.DATABASE.{c}rbl.csv.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shmlast:1.6--py_0
