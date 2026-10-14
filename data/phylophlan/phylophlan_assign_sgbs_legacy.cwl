cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phylophlan_assign_sgbs_legacy
label: phylophlan_assign_sgbs_legacy
doc: "Assigns SGB and taxonomy to a given set of input genomes (older Mash-based version): the closest SGBs sorted by average Mash distance, the closest SGB, GGB, FGB and reference genomes, or an all-vs-all Mash distance matrix.\n\nTool homepage: https://github.com/biobakery/phylophlan"
inputs:
  - id: input
    type:
      - 'null'
      - Directory
    doc: "Input folder containing the metagenomic bins to be indexed"
    inputBinding:
      position: 1
      prefix: "--input"
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: "Prefix used for the output folders: indexed bins, distance estimations"
    inputBinding:
      position: 1
      prefix: "--output_prefix"
  - id: database
    type:
      - 'null'
      - string
    doc: "Database name"
    inputBinding:
      position: 1
      prefix: "--database"
  - id: database_list
    type:
      - 'null'
      - boolean
    doc: "List all the available databases"
    inputBinding:
      position: 1
      prefix: "--database_list"
  - id: database_update
    type:
      - 'null'
      - boolean
    doc: "Update the databases file"
    inputBinding:
      position: 1
      prefix: "--database_update"
  - id: input_extension
    type:
      - 'null'
      - string
    doc: "Extension of the input file(s); if not specified it is inferred from the input files"
    inputBinding:
      position: 1
      prefix: "--input_extension"
  - id: how_many
    type:
      - 'null'
      - string
    doc: "Number of SGBs to report in the output; \"all\" reports all (default: 10)"
    inputBinding:
      position: 1
      prefix: "--how_many"
  - id: nproc
    type:
      - 'null'
      - int
    doc: "Number of CPUs (default: 1)"
    inputBinding:
      position: 1
      prefix: "--nproc"
  - id: database_folder
    type:
      - 'null'
      - Directory
    doc: "Folder that contains the database file (default: phylophlan_databases/)"
    inputBinding:
      position: 1
      prefix: "--database_folder"
  - id: only_input
    type:
      - 'null'
      - boolean
    doc: "Provide a distance matrix between only the input genomes"
    inputBinding:
      position: 1
      prefix: "--only_input"
  - id: add_ggb
    type:
      - 'null'
      - boolean
    doc: "Add GGB assignments"
    inputBinding:
      position: 1
      prefix: "--add_ggb"
  - id: add_fgb
    type:
      - 'null'
      - boolean
    doc: "Add FGB assignments"
    inputBinding:
      position: 1
      prefix: "--add_fgb"
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: "Overwrite the output file if it exists"
    inputBinding:
      position: 1
      prefix: "--overwrite"
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Prints more stuff"
    inputBinding:
      position: 1
      prefix: "--verbose"
outputs:
  - id: results
    type:
      - 'null'
      - type: array
        items: File
    doc: "Output tables"
    outputBinding:
      glob: "$(inputs.output_prefix)*"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylophlan:3.2.1--pyhdfd78af_0
stdout: phylophlan_assign_sgbs_legacy.out
