cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-label-merge'
label: connectome-workbench_wb_command_label-merge
doc: "Merge label files into a new file by concatenating columns from them. The input files must have the same number of vertices and the same structure.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: label_out
    type: string
    doc: output - the output label
    inputBinding:
      position: 1
  - id: label_column_options
    type:
      - 'null'
      - type: array
        items:
          type: array
          items: string
    doc: "per-file column selection, paired with label_files; each entry is a list of words placed after that file, e.g. [-column, '1', -up-to, '3', -reverse]; use [] for all columns"
  - id: label_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'repeatable -label: label files to use columns from'
    inputBinding:
      position: 2
      valueFrom: "${ if (!self) return null; var a = []; for (var i = 0; i < self.length; i++) { a.push('-label', self[i].path); var o = inputs.label_column_options; if (o && o[i]) { a = a.concat(o[i]); } } return a; }"
outputs:
  - id: merged_label
    type: File
    doc: the output label file
    outputBinding:
      glob: $(inputs.label_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
