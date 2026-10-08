cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-cifti-separate'
label: connectome-workbench_wb_command_cifti-separate
doc: "Write a cifti structure as metric, label or volume. For dtseries, dscalar, and dlabel, use COLUMN for <direction>. You must specify at least one of -metric, -volume-all, -volume, or -label. Output volumes spatially line up with their original positions, whether or not they are cropped.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: cifti_in
    type: File
    doc: the cifti to separate a component of
    inputBinding:
      position: 1
  - id: direction
    type: string
    doc: which direction to separate into components, ROW or COLUMN
    inputBinding:
      position: 2
  - id: volume_all
    type:
      - 'null'
      - string
    doc: output - separate all volume structures into this volume file
    inputBinding:
      position: 10
      prefix: '-volume-all'
  - id: volume_all_roi
    type:
      - 'null'
      - string
    doc: 'output - with volume_all: also output the roi of which voxels have data'
    inputBinding:
      position: 11
      prefix: '-roi'
  - id: volume_all_label
    type:
      - 'null'
      - string
    doc: 'output - with volume_all: a volume label file indicating the location of structures'
    inputBinding:
      position: 12
      prefix: '-label'
  - id: volume_all_crop
    type:
      - 'null'
      - boolean
    doc: 'with volume_all: crop volume to the size of the data rather than using the original volume size'
    inputBinding:
      position: 13
      prefix: '-crop'
  - id: label
    type:
      - 'null'
      - type: array
        items:
          type: array
          items: string
        inputBinding:
          prefix: '-label'
    doc: 'repeatable -label: separate a surface model into a surface label file; each entry is [structure, label-out] or [structure, label-out, -roi, roi-out]'
    inputBinding:
      position: 14
  - id: metric
    type:
      - 'null'
      - type: array
        items:
          type: array
          items: string
        inputBinding:
          prefix: '-metric'
    doc: 'repeatable -metric: separate a surface model into a metric file; each entry is [structure, metric-out] or [structure, metric-out, -roi, roi-out]'
    inputBinding:
      position: 15
  - id: volume
    type:
      - 'null'
      - type: array
        items:
          type: array
          items: string
        inputBinding:
          prefix: '-volume'
    doc: 'repeatable -volume: separate a volume structure into a volume file; each entry is [structure, volume-out], optionally followed by -roi roi-out and/or -crop'
    inputBinding:
      position: 16
outputs:
  - id: volume_all_out
    type:
      - 'null'
      - File
    doc: the output volume of all volume structures
    outputBinding:
      glob: $(inputs.volume_all)
  - id: volume_all_roi_out
    type:
      - 'null'
      - File
    doc: the roi output volume
    outputBinding:
      glob: $(inputs.volume_all_roi)
  - id: volume_all_label_out
    type:
      - 'null'
      - File
    doc: the label output volume
    outputBinding:
      glob: $(inputs.volume_all_label)
  - id: separated_files
    type:
      type: array
      items: File
    doc: files written by -label, -metric and -volume (and their -roi outputs)
    outputBinding:
      glob: "${ var g = []; ['label', 'metric', 'volume'].forEach(function (k) { (inputs[k] || []).forEach(function (a) { g.push(a[1]); var i = a.indexOf('-roi'); if (i >= 0) { g.push(a[i + 1]); } }); }); return g; }"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
