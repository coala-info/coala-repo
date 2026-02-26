cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyfish
label: pyfish
doc: "Create a Fish (Muller) plot for the given evolutionary tree.\n\nTool homepage:
  https://bitbucket.org/schwarzlab/pyfish"
inputs:
  - id: populations
    type: File
    doc: A CSV file with the header "Id,Step,Pop".
    inputBinding:
      position: 1
  - id: parent_tree
    type: File
    doc: A CSV file with the header "ParentId,ChildId".
    inputBinding:
      position: 2
  - id: absolute
    type:
      - 'null'
      - boolean
    doc: Plot the populations in absolute numbers rather than normalized.
    inputBinding:
      position: 103
      prefix: --absolute
  - id: cmap
    type:
      - 'null'
      - string
    doc: Colormap to use. Has to be a matplotlib colormap Uses rainbow by 
      default
    inputBinding:
      position: 103
      prefix: --cmap
  - id: color_by
    type:
      - 'null'
      - string
    doc: Color the fishplot based on this column of the populations dataframe
    inputBinding:
      position: 103
      prefix: --color-by
  - id: first_step
    type:
      - 'null'
      - int
    doc: The step to start plotting from.
    inputBinding:
      position: 103
      prefix: --first
  - id: height
    type:
      - 'null'
      - int
    doc: Output image height
    inputBinding:
      position: 103
      prefix: --height
  - id: interpolation
    type:
      - 'null'
      - int
    doc: Order of interpolation for empty data (0 means no interpolation).
    inputBinding:
      position: 103
      prefix: --interpolation
  - id: last_step
    type:
      - 'null'
      - int
    doc: The step to end the plotting at.
    inputBinding:
      position: 103
      prefix: --last
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed for selection of colors.
    inputBinding:
      position: 103
      prefix: --seed
  - id: smooth
    type:
      - 'null'
      - float
    doc: STDev for Gaussian convolutional filter. The higher the value the 
      smoother the resulting bands will be. Recommended is around 1.0.
    inputBinding:
      position: 103
      prefix: --smooth
  - id: width
    type:
      - 'null'
      - int
    doc: Output image width
    inputBinding:
      position: 103
      prefix: --width
outputs:
  - id: output
    type: File
    doc: Output image filepath. The format must support alpha channels.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfish:1.0.3--pyh7cba7a3_0
