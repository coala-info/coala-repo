cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -surface-average
label: connectome-workbench_wb_command_surface-average
doc: 'The 3D sample standard deviation is computed as ''sqrt(sum(squaredlength(xyz
  - mean(xyz)))/(n - 1))''.


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
requirements:
  - class: SchemaDefRequirement
    types:
      - name: surf_rec
        type: record
        fields:
          - name: surface
            type: File
            doc: a surface file to average
            inputBinding:
              position: 1
          - name: weight
            type:
              - 'null'
              - float
            doc: specify a weighted average
            inputBinding:
              position: 2
              prefix: -weight
inputs:
  - id: surface_out
    type: string
    doc: output - the output averaged surface
    inputBinding:
      position: 1
  - id: stddev
    type:
      - 'null'
      - string
    doc: compute 3D sample standard deviation
    inputBinding:
      position: 2
      prefix: -stddev
  - id: uncertainty
    type:
      - 'null'
      - string
    doc: compute caret5 'uncertainty'
    inputBinding:
      position: 2
      prefix: -uncertainty
  - id: surf
    type:
      - 'null'
      - type: array
        items: surf_rec
        inputBinding:
          prefix: -surf
    doc: specify a surface to include in the average
    inputBinding:
      position: 2
outputs:
  - id: surface_out_file
    type: File
    doc: the output averaged surface
    outputBinding:
      glob: $(inputs.surface_out)
  - id: stddev_file
    type:
      - 'null'
      - File
    doc: the output metric for 3D sample standard deviation
    outputBinding:
      glob: $(inputs.stddev)
  - id: uncertainty_file
    type:
      - 'null'
      - File
    doc: the output metric for uncertainty
    outputBinding:
      glob: $(inputs.uncertainty)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
