cwlVersion: v1.2
class: CommandLineTool
baseCommand: swissprot_to_table.rb
label: protk_swissprot_to_table.rb
doc: 'Query a swissprot flat file and output to tab delimited table.


  Tool homepage: https://github.com/iracooke/protk'
inputs:
  - id: queries_file
    type: File
    doc: Text file of queries (Uniprot accessions)
    inputBinding:
      position: 1
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Run in debug mode
    inputBinding:
      position: 102
      prefix: --debug
  - id: database
    type: File
    doc: Uniprot flatfile database containing full records for proteins (staged in the working directory
      because the tool writes its index files beside it)
    inputBinding:
      position: 102
      prefix: --database
      valueFrom: $(self.basename)
  - id: keys
    type:
      - 'null'
      - string
    doc: Filter output to only the specified keys (comma separated)
    inputBinding:
      position: 102
      prefix: --keys
  - id: show_keys
    type:
      - 'null'
      - boolean
    doc: Print a list of possible values for the keys field and exit [false]
    inputBinding:
      position: 102
      prefix: --show-keys
  - id: separator
    type:
      - 'null'
      - string
    doc: Separator character for output, default (tab)
    inputBinding:
      position: 102
      prefix: --separator
  - id: array_separator
    type:
      - 'null'
      - string
    doc: Array Separator character, default ,
    inputBinding:
      position: 102
      prefix: --array-separator
  - id: query_separator
    type:
      - 'null'
      - string
    doc: Separator character for queries.txt, default is tab
    inputBinding:
      position: 102
      prefix: --query-separator
  - id: id_column
    type:
      - 'null'
      - int
    doc: Column in queries.txt in which Uniprot Accessions are found [1]
    inputBinding:
      position: 102
      prefix: --id-column
  - id: output_path
    type: string
    doc: An explicitly named output file.
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: An explicitly named output file.
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.database)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
