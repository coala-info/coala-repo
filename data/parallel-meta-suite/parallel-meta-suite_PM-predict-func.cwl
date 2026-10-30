cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - PM-predict-func
label: parallel-meta-suite_PM-predict-func
doc: "Functional prediction\n\nTool homepage: https://github.com/qdu-bioinfo/parallel-meta-suite"
inputs:
  - id: ref_database
    type:
      - 'null'
      - string
    doc: "Reference database (the help gives 'Empty database' as the default text)"
    inputBinding:
      position: 1
      prefix: "-D"
  - id: input_file
    type:
      - 'null'
      - File
    doc: "Input single file"
    inputBinding:
      position: 1
      prefix: "-i"
  - id: list_file
    type:
      - 'null'
      - File
    doc: "Input files list"
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
  - id: otu_count_table
    type:
      - 'null'
      - File
    doc: "Input OTU count table (*.OTU.Count)"
    inputBinding:
      position: 1
      prefix: "-T"
  - id: output_path
    type:
      - 'null'
      - string
    doc: "Output path, default is \"Results_Func\""
    default: Results_Func
    inputBinding:
      position: 1
      prefix: "-o"
  - id: output_list
    type:
      - 'null'
      - string
    doc: "If output list (at \"Output_path/func.list\"), T(rue) or F(alse), default is T [optional for -l]"
    inputBinding:
      position: 1
      prefix: "-L"
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads, default is auto"
    inputBinding:
      position: 1
      prefix: "-t"
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: "Predicted functional profiles"
    outputBinding:
      glob: "$(inputs.output_path)"
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
stdout: parallel-meta-suite_PM-predict-func.out
