cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - PM-select-func
label: parallel-meta-suite_PM-select-func
doc: "Select the functional features\n\nTool homepage: https://github.com/qdu-bioinfo/parallel-meta-suite"
inputs:
  - id: list_file
    type:
      - 'null'
      - File
    doc: "Input files list [Conflicts with -T]"
    inputBinding:
      position: 1
      prefix: "-l"
  - id: list_path_prefix
    type:
      - 'null'
      - string
    doc: "List file path prefix [Optional for -l]"
    inputBinding:
      position: 1
      prefix: "-p"
  - id: list_members
    type:
      - 'null'
      - {type: array, items: File}
    doc: "Files named in the list; staged in the working directory so that the names in the list resolve"
  - id: ko_count_table
    type:
      - 'null'
      - File
    doc: "Input KO Absolute Count table (*.KO.Count) [Conflicts with -l]"
    inputBinding:
      position: 1
      prefix: "-T"
  - id: output_file
    type:
      - 'null'
      - string
    doc: "Output file, default is \"functions_category\""
    default: functions_category
    inputBinding:
      position: 1
      prefix: "-o"
  - id: pathway_level
    type:
      - 'null'
      - int
    doc: "KEGG Pathway level, Level 1, 2, 3 or 4 (KO number), default is 2"
    inputBinding:
      position: 1
      prefix: "-L"
  - id: print_barchart
    type:
      - 'null'
      - string
    doc: "Print distribution barchart, T(rue) or F(alse), default is F"
    inputBinding:
      position: 1
      prefix: "-P"
outputs:
  - id: selected_tables
    type: {type: array, items: File}
    doc: "Selected functional abundance tables and plots"
    outputBinding:
      glob: "$(inputs.output_file + '*')"
  - id: stdout
    type: stdout
    doc: "Standard output (screen messages)"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '$(inputs.list_members ? inputs.list_members : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parallel-meta-suite:1.0--h7d875b9_1
stdout: parallel-meta-suite_PM-select-func.out
