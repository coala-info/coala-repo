cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -metric-to-volume-mapping
label: connectome-workbench_wb_command_metric-to-volume-mapping
doc: 'Maps values from a metric file into a volume file. You must specify exactly
  one mapping method option. The -nearest-vertex method uses the value from the vertex
  closest to the voxel center (useful for integer values). The -ribbon-constrained
  method uses the same method as in -volume-to-surface-mapping, then uses the weights
  in reverse. Mapping to lower resolutions than the mesh may require a larger -voxel-subdiv
  value in order to have all of the surface data participate.


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
requirements:
  - class: SchemaDefRequirement
    types:
      - name: ribbon_constrained_rec
        type: record
        fields:
          - name: inner_surf
            type: File
            doc: the inner surface of the ribbon
            inputBinding:
              position: 1
          - name: outer_surf
            type: File
            doc: the outer surface of the ribbon
            inputBinding:
              position: 2
          - name: voxel_subdiv
            type:
              - 'null'
              - int
            doc: voxel divisions while estimating voxel weights
            inputBinding:
              position: 3
              prefix: -voxel-subdiv
          - name: greedy
            type:
              - 'null'
              - boolean
            doc: instead of antialiasing partial-volumed voxels, put full metric values
              (legacy behavior)
            inputBinding:
              position: 3
              prefix: -greedy
          - name: thick_columns
            type:
              - 'null'
              - boolean
            doc: use overlapping columns (legacy method)
            inputBinding:
              position: 3
              prefix: -thick-columns
inputs:
  - id: metric
    type: File
    doc: the input metric file
    inputBinding:
      position: 1
  - id: surface
    type: File
    doc: the surface to use coordinates from
    inputBinding:
      position: 2
  - id: volume_space
    type: File
    doc: a volume file in the desired output volume space
    inputBinding:
      position: 3
  - id: volume_out
    type: string
    doc: output - the output volume file
    inputBinding:
      position: 4
  - id: nearest_vertex
    type:
      - 'null'
      - float
    doc: use the value from the vertex closest to the voxel center
    inputBinding:
      position: 5
      prefix: -nearest-vertex
  - id: ribbon_constrained
    type:
      - 'null'
      - ribbon_constrained_rec
    doc: use ribbon constrained mapping algorithm
    inputBinding:
      position: 5
      prefix: -ribbon-constrained
outputs:
  - id: volume_out_file
    type: File
    doc: the output volume file
    outputBinding:
      glob: $(inputs.volume_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
