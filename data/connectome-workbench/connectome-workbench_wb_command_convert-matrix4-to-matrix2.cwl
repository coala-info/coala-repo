cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-convert-matrix4-to-matrix2'
label: connectome-workbench_wb_command_convert-matrix4-to-matrix2
doc: "Generate a matrix2 cifti from a matrix4 wbsparse file. Makes a cifti file from the fiber counts, and optionally a second cifti file from the distances. Per-fiber counts are stored as approximate fractions.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: matrix4_wbsparse
    type: File
    doc: a wbsparse matrix4 file
    inputBinding:
      position: 1
  - id: counts_out
    type: string
    doc: output - the total fiber counts, as a cifti file
    inputBinding:
      position: 2
  - id: distances
    type:
      - 'null'
      - string
    doc: output - output average trajectory distance, as a cifti file
    inputBinding:
      position: 3
      prefix: '-distances'
  - id: individual_fibers
    type:
      - 'null'
      - type: array
        items: string
    doc: 'output files for each fiber direction; three names: first, second, third fiber'
    inputBinding:
      position: 4
      prefix: '-individual-fibers'
outputs:
  - id: counts
    type: File
    doc: the total fiber counts cifti
    outputBinding:
      glob: $(inputs.counts_out)
  - id: distances_out
    type:
      - 'null'
      - File
    doc: the distances cifti
    outputBinding:
      glob: $(inputs.distances)
  - id: individual_fiber_files
    type:
      type: array
      items: File
    doc: per-fiber cifti files
    outputBinding:
      glob: '$(inputs.individual_fibers ? inputs.individual_fibers : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
