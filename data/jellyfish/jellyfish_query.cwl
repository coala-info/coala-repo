cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jellyfish
  - query
label: jellyfish_query
doc: "Query a Jellyfish database\n\nTool homepage: http://www.genome.umd.edu/jellyfish.html"
inputs:
  - id: file
    type: File
    doc: Path to the Jellyfish database file
    inputBinding:
      position: 1
  - id: mers
    type:
      type: array
      items: string
    doc: Mers to query
    inputBinding:
      position: 2
  - id: interactive
    type:
      - 'null'
      - boolean
    doc: Interactive, queries from stdin
    inputBinding:
      position: 103
      prefix: --interactive
  - id: load
    type:
      - 'null'
      - boolean
    doc: Force pre-loading of database file into memory
    inputBinding:
      position: 103
      prefix: --load
  - id: no_load
    type:
      - 'null'
      - boolean
    doc: Disable pre-loading of database file into memory
    inputBinding:
      position: 103
      prefix: --no-load
  - id: sequence
    type:
      - 'null'
      - File
    doc: Output counts for all mers in sequence
    inputBinding:
      position: 103
      prefix: --sequence
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/jellyfish:v2.2.10-2-deb_cv1
