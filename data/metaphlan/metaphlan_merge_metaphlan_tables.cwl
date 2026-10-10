cwlVersion: v1.2
class: CommandLineTool
baseCommand: merge_metaphlan_tables.py
label: metaphlan_merge_metaphlan_tables
doc: "Performs a table join on one or more metaphlan output files.\n\nTool homepage: https://github.com/biobakery/metaphlan"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.list_members ? inputs.list_members : [])"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "One or more tab-delimited text tables to join"
    inputBinding:
      position: 1
  - id: file_list
    type:
      - 'null'
      - File
    doc: "Name of file containing the paths to the files to combine"
    inputBinding:
      position: 101
      prefix: "-l"
  - id: list_members
    type:
      - 'null'
      - type: array
        items: File
    doc: "The files named in the file list; they are staged in the working directory so that the names in the list resolve"
  - id: output_name
    type:
      - 'null'
      - string
    doc: "Name of output file in which joined tables are saved (output.txt)"
    inputBinding:
      position: 101
      prefix: "-o"
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: "Overwrite output file if exists"
    inputBinding:
      position: 101
      prefix: "--overwrite"
  - id: gtdb_profiles
    type:
      - 'null'
      - boolean
    doc: "To specify when running the script with GTDB-based profiles"
    inputBinding:
      position: 101
      prefix: "--gtdb_profiles"
outputs:
  - id: merged_table
    type:
      - 'null'
      - File
    doc: "The joined table (written when -o is given)"
    outputBinding:
      glob: "$(inputs.output_name)"
  - id: stdout
    type: stdout
    doc: "Joined table on standard output (when -o is not given)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaphlan:4.2.4--pyhdfd78af_0
stdout: metaphlan_merge_metaphlan_tables.out
