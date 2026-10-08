cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -cifti-export-dense-mapping
label: connectome-workbench_wb_command_cifti-export-dense-mapping
doc: "This command produces text files that describe the mapping from cifti indices to surface vertices or voxels. All indices are zero-based. The default format for -surface is lines of the form: <cifti-index> <vertex> The default format for -volume and -volume-all is lines of the form: <cifti-index> <i> <j> <k> For each <structure> argument, use one of the following strings:\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
requirements:
  - class: InlineJavascriptRequirement
  - class: SchemaDefRequirement
    types:
      - name: surface_item
        type: record
        fields:
          - name: structure
            type: string
            doc: the structure to output
            inputBinding:
              position: 1
              prefix: -surface
          - name: text_out
            type: string
            doc: the output text file
            inputBinding:
              position: 2
          - name: no_cifti_index
            type:
              - 'null'
              - boolean
            doc: don't write the cifti index in the output file
            inputBinding:
              position: 3
              prefix: -no-cifti-index
      - name: volume_item
        type: record
        fields:
          - name: structure
            type: string
            doc: the structure to output
            inputBinding:
              position: 1
              prefix: -volume
          - name: text_out
            type: string
            doc: the output text file
            inputBinding:
              position: 2
          - name: no_cifti_index
            type:
              - 'null'
              - boolean
            doc: don't write the cifti index in the output file
            inputBinding:
              position: 3
              prefix: -no-cifti-index
inputs:
  - id: cifti
    type: File
    doc: the cifti file
    inputBinding:
      position: 1
  - id: direction
    type: string
    doc: which direction to export the mapping from, ROW or COLUMN
    inputBinding:
      position: 2
  - id: volume_all
    type:
      - 'null'
      - string
    doc: 'export the the mapping of all voxels: the output text file'
    inputBinding:
      position: 3
      prefix: -volume-all
  - id: no_cifti_index
    type:
      - 'null'
      - boolean
    doc: don't write the cifti index in the output file (use with -volume-all)
    inputBinding:
      position: 4
      prefix: -no-cifti-index
  - id: structure
    type:
      - 'null'
      - boolean
    doc: write the structure each voxel belongs to in the output file (use with -volume-all)
    inputBinding:
      position: 5
      prefix: -structure
  - id: surface
    type:
      - 'null'
      - type: array
        items: surface_item
    doc: export the the mapping of one surface structure (repeatable; one record per use of -surface)
    inputBinding:
      position: 6
  - id: volume
    type:
      - 'null'
      - type: array
        items: volume_item
    doc: export the the mapping of one volume structure (repeatable; one record per use of -volume)
    inputBinding:
      position: 7
outputs:
  - id: volume_all_file
    type:
      - 'null'
      - File
    doc: the output text file
    outputBinding:
      glob: $(inputs.volume_all)
  - id: surface_text_out
    type:
      type: array
      items: File
    doc: the output text file
    outputBinding:
      glob: ${ var r = []; (inputs.surface || []).forEach(function (e) { if (e.text_out) { r.push(e.text_out); } }); return r; }
  - id: volume_text_out
    type:
      type: array
      items: File
    doc: the output text file
    outputBinding:
      glob: ${ var r = []; (inputs.volume || []).forEach(function (e) { if (e.text_out) { r.push(e.text_out); } }); return r; }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
