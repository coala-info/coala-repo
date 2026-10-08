cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -cifti-create-dense-from-template
label: connectome-workbench_wb_command_cifti-create-dense-from-template
doc: "This command helps you make a new dscalar, dtseries, or dlabel cifti file that matches the brainordinate space used in another cifti file. The template file must have the desired brainordinate space in the mapping along the column direction (for dtseries, dscalar, dlabel, and symmetric dconn this is always the case). All input cifti files must have a brain models mapping along column and use the same volume space and/or surface vertex count as the template for structures that they contain. If any input files contain label data, then input files with non-label data are not allowed, and the -series option may not be used. Any structure that isn't covered by an input is filled with zeros or the unlabeled key. The <structure> argument of -metric, -label or -volume must be one of the following:\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
requirements:
  - class: SchemaDefRequirement
    types:
      - name: metric_item
        type: record
        fields:
          - name: structure
            type: string
            doc: which structure to put the metric file into
            inputBinding:
              position: 1
              prefix: -metric
          - name: metric_in
            type: File
            doc: input metric file
            inputBinding:
              position: 2
      - name: label_item
        type: record
        fields:
          - name: structure
            type: string
            doc: which structure to put the label file into
            inputBinding:
              position: 1
              prefix: -label
          - name: label_in
            type: File
            doc: input label file
            inputBinding:
              position: 2
      - name: volume_item
        type: record
        fields:
          - name: structure
            type: string
            doc: which structure to put the volume file into
            inputBinding:
              position: 1
              prefix: -volume
          - name: volume_in
            type: File
            doc: the input volume file
            inputBinding:
              position: 2
          - name: from_cropped
            type:
              - 'null'
              - boolean
            doc: the input is cropped to the size of the volume structure
            inputBinding:
              position: 3
              prefix: -from-cropped
inputs:
  - id: template_cifti
    type: File
    doc: file to match brainordinates of
    inputBinding:
      position: 1
  - id: cifti_out
    type: string
    doc: the output cifti file
    inputBinding:
      position: 2
  - id: series_step
    type:
      - 'null'
      - float
    doc: increment between series points
    inputBinding:
      position: 3
      prefix: -series
  - id: series_start
    type:
      - 'null'
      - float
    doc: start value of the series (give with series_step)
    inputBinding:
      position: 4
  - id: unit
    type:
      - 'null'
      - string
    doc: 'select unit for series (default SECOND): unit identifier (use with -series)'
    inputBinding:
      position: 5
      prefix: -unit
  - id: volume_all
    type:
      - 'null'
      - File
    doc: 'specify an input volume file for all voxel data: the input volume file'
    inputBinding:
      position: 6
      prefix: -volume-all
  - id: from_cropped
    type:
      - 'null'
      - boolean
    doc: the input is cropped to the size of the voxel data in the template file (use with -volume-all)
    inputBinding:
      position: 7
      prefix: -from-cropped
  - id: cifti
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: -cifti
    doc: 'use input data from a cifti file: cifti file containing input data (repeatable)'
    inputBinding:
      position: 8
  - id: metric
    type:
      - 'null'
      - type: array
        items: metric_item
    doc: use input data from a metric file (repeatable; one record per use of -metric)
    inputBinding:
      position: 9
  - id: label
    type:
      - 'null'
      - type: array
        items: label_item
    doc: use input data from surface label files (repeatable; one record per use of -label)
    inputBinding:
      position: 10
  - id: volume
    type:
      - 'null'
      - type: array
        items: volume_item
    doc: use a volume file for a single volume structure's data (repeatable; one record per use of -volume)
    inputBinding:
      position: 11
outputs:
  - id: cifti_out_file
    type: File
    doc: the output cifti file
    outputBinding:
      glob: $(inputs.cifti_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
