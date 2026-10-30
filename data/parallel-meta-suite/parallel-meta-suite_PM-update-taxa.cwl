cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - PM-update-taxa
label: parallel-meta-suite_PM-update-taxa
doc: "Update the taxonomy annotation to the latest version\n\nTool homepage: https://github.com/qdu-bioinfo/parallel-meta-suite"
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
    doc: "Input single file (updated in place; a .bk copy of the old file is kept)"
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
outputs:
  - id: updated_file
    type:
      - 'null'
      - File
    doc: "The input file after the taxonomy update"
    outputBinding:
      glob: "$(inputs.input_file ? inputs.input_file.basename : [])"
  - id: updated_list_members
    type:
      - 'null'
      - {type: array, items: File}
    doc: "The listed files after the taxonomy update"
    outputBinding:
      glob: "$(inputs.list_members ? inputs.list_members.map(function(f){return f.basename;}) : [])"
  - id: stdout
    type: stdout
    doc: "Standard output (screen messages)"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${ var l = []; if (inputs.input_file) l.push({"entry": inputs.input_file, "writable": true});
         (inputs.list_members ? inputs.list_members : []).forEach(function(f){ l.push({"entry": f, "writable": true}); });
         if (inputs.list_file) l.push(inputs.list_file); return l; }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parallel-meta-suite:1.0--h7d875b9_1
stdout: parallel-meta-suite_PM-update-taxa.out
