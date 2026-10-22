cwlVersion: v1.2
class: CommandLineTool
baseCommand: socru_shrink_database
label: socru_shrink_database
doc: "Admin utility to take a database and blast results and create a new shrunk database\n\nTool homepage: https://github.com/quadram-institute-bioscience/socru"
inputs:
  - id: blast_results
    type: File
    doc: Blast results file from running socru -b xxx against multiple assemblies
    inputBinding:
      position: 1
  - id: input_database
    type: Directory
    doc: Directory containing database to shrink
    inputBinding:
      position: 2
  - id: output_database
    type: string
    doc: Output directory for new database, it must not already exist
    inputBinding:
      position: 3
  - id: min_fragment_size
    type:
      - 'null'
      - int
    doc: Minimum fragment size in bases (default 100000)
    inputBinding:
      position: 103
      prefix: --min_fragment_size
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Turn on debugging
    inputBinding:
      position: 103
      prefix: --debug
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Turn on verbose output
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: shrunk_database
    type: Directory
    doc: New shrunk database
    outputBinding:
      glob: $(inputs.output_database)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/socru:2.2.5--pyhdfd78af_0
stdout: socru_shrink_database.out
