cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -cifti-label-to-border
label: connectome-workbench_wb_command_cifti-label-to-border
doc: "For each surface, takes the labels on the matching structure and draws borders around the labels. Use -column to only draw borders around one label map.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
requirements:
  - class: InlineJavascriptRequirement
  - class: SchemaDefRequirement
    types:
      - name: border_item
        type: record
        fields:
          - name: surface
            type: File
            doc: the surface to use for neighbor and structure information
            inputBinding:
              position: 1
              prefix: -border
          - name: border_out
            type: string
            doc: the output border file
            inputBinding:
              position: 2
inputs:
  - id: cifti_in
    type: File
    doc: the input cifti dlabel file
    inputBinding:
      position: 1
  - id: placement
    type:
      - 'null'
      - float
    doc: 'set how far along the edge border points are drawn: fraction along edge from inside vertex (default 0.33)'
    inputBinding:
      position: 2
      prefix: -placement
  - id: column
    type:
      - 'null'
      - string
    doc: 'select a single column: the column number or name'
    inputBinding:
      position: 3
      prefix: -column
  - id: border
    type:
      - 'null'
      - type: array
        items: border_item
    doc: specify output file for a surface structure (repeatable; one record per use of -border)
    inputBinding:
      position: 4
outputs:
  - id: border_border_out
    type:
      type: array
      items: File
    doc: the output border file
    outputBinding:
      glob: ${ var r = []; (inputs.border || []).forEach(function (e) { if (e.border_out) { r.push(e.border_out); } }); return r; }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
