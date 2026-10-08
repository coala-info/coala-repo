cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-cifti-replace-structure'
label: connectome-workbench_wb_command_cifti-replace-structure
doc: "Replace data in a structure in a cifti file. The cifti file is modified in place (a copy is written to the output folder under the same name). You must specify at least one of -metric, -label, -volume, or -volume-all. Input volumes must line up with the output of -cifti-separate. For dtseries/dscalar, use COLUMN.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.cifti)
        writable: true
inputs:
  - id: cifti
    type: File
    doc: the cifti to modify (a modified copy with the same name is written)
    inputBinding:
      position: 1
  - id: direction
    type: string
    doc: which dimension to interpret as a single map, ROW or COLUMN
    inputBinding:
      position: 2
  - id: volume_all
    type:
      - 'null'
      - File
    doc: replace the data in all volume components with this volume
    inputBinding:
      position: 10
      prefix: '-volume-all'
  - id: volume_all_from_cropped
    type:
      - 'null'
      - boolean
    doc: 'with volume_all: the input is cropped to the size of the data'
    inputBinding:
      position: 11
      prefix: '-from-cropped'
  - id: discard_unused_labels
    type:
      - 'null'
      - boolean
    doc: when operating on a dlabel file, drop any unused label keys from the label table
    inputBinding:
      position: 12
      prefix: '-discard-unused-labels'
  - id: label_structures
    type:
      - 'null'
      - type: array
        items: string
    doc: structures for -label, one per entry of label_files (structure name such as CORTEX_LEFT, CORTEX_RIGHT, CEREBELLUM, THALAMUS_LEFT)
  - id: label_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'repeatable -label: input label files that replace the data in a surface label component, paired with label_structures'
    inputBinding:
      position: 13
      valueFrom: "${ if (!self) return null; var a = []; for (var i = 0; i < self.length; i++) { a.push('-label', inputs.label_structures[i], self[i].path); } return a; }"
  - id: metric_structures
    type:
      - 'null'
      - type: array
        items: string
    doc: structures for -metric, one per entry of metric_files (structure name such as CORTEX_LEFT, CORTEX_RIGHT, CEREBELLUM, THALAMUS_LEFT)
  - id: metric_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'repeatable -metric: input metrics that replace the data in a surface component, paired with metric_structures'
    inputBinding:
      position: 14
      valueFrom: "${ if (!self) return null; var a = []; for (var i = 0; i < self.length; i++) { a.push('-metric', inputs.metric_structures[i], self[i].path); } return a; }"
  - id: volume_structures
    type:
      - 'null'
      - type: array
        items: string
    doc: structures for -volume, one per entry of volume_files (structure name such as CORTEX_LEFT, CORTEX_RIGHT, CEREBELLUM, THALAMUS_LEFT)
  - id: volume_from_cropped
    type:
      - 'null'
      - boolean
    doc: 'add -from-cropped to every -volume entry: the inputs are cropped to the size of the component'
  - id: volume_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'repeatable -volume: input volumes that replace the data in a volume component, paired with volume_structures'
    inputBinding:
      position: 15
      valueFrom: "${ if (!self) return null; var a = []; for (var i = 0; i < self.length; i++) { a.push('-volume', inputs.volume_structures[i], self[i].path); if (inputs.volume_from_cropped) { a.push('-from-cropped'); } } return a; }"
outputs:
  - id: cifti_out
    type: File
    doc: the modified cifti file
    outputBinding:
      glob: $(inputs.cifti.basename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
