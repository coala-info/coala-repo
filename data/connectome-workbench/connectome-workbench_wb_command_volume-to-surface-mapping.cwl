cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -volume-to-surface-mapping
label: connectome-workbench_wb_command_volume-to-surface-mapping
doc: "You must specify exactly one mapping method. Enclosing voxel uses the value from the voxel the vertex lies inside, while trilinear does a 3D linear interpolation based on the voxels immediately on each side of the vertex's position.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: volume
    type: File
    doc: "the volume to map data from"
    inputBinding:
      position: 1
  - id: surface
    type: File
    doc: "the surface to map the data onto"
    inputBinding:
      position: 2
  - id: metric_out
    type: string
    doc: "output - the output metric file"
    inputBinding:
      position: 3
  - id: trilinear
    type:
      - 'null'
      - boolean
    doc: "use trilinear volume interpolation"
    inputBinding:
      position: 4
      prefix: -trilinear
  - id: enclosing
    type:
      - 'null'
      - boolean
    doc: "use value of the enclosing voxel"
    inputBinding:
      position: 5
      prefix: -enclosing
  - id: cubic
    type:
      - 'null'
      - boolean
    doc: "use cubic splines"
    inputBinding:
      position: 6
      prefix: -cubic
  - id: ribbon_inner_surf
    type:
      - 'null'
      - File
    doc: "the inner surface of the ribbon (-ribbon-constrained argument 1 of 2)"
    inputBinding:
      position: 7
      prefix: -ribbon-constrained
  - id: ribbon_outer_surf
    type:
      - 'null'
      - File
    doc: "the outer surface of the ribbon (-ribbon-constrained argument 2 of 2)"
    inputBinding:
      position: 8
  - id: volume_roi
    type:
      - 'null'
      - File
    doc: "use a volume roi: the volume file (sub-option of -ribbon-constrained)"
    inputBinding:
      position: 9
      prefix: -volume-roi
  - id: voxel_subdiv
    type:
      - 'null'
      - int
    doc: "voxel divisions while estimating voxel weights: number of subdivisions, default 3 (sub-option of -ribbon-constrained)"
    inputBinding:
      position: 10
      prefix: -voxel-subdiv
  - id: thin_columns
    type:
      - 'null'
      - boolean
    doc: "use non-overlapping polyhedra (sub-option of -ribbon-constrained)"
    inputBinding:
      position: 11
      prefix: -thin-columns
  - id: gaussian
    type:
      - 'null'
      - float
    doc: "reduce weight to voxels that aren't near <surface>: value to multiply the local thickness by, to get the gaussian sigma (sub-option of -ribbon-constrained)"
    inputBinding:
      position: 12
      prefix: -gaussian
  - id: output_weights_vertex
    type:
      - 'null'
      - int
    doc: "the vertex number to get the voxel weights for, 0-based (-output-weights argument 1 of 2) (sub-option of -ribbon-constrained)"
    inputBinding:
      position: 13
      prefix: -output-weights
  - id: output_weights_out
    type:
      - 'null'
      - string
    doc: "output - volume to write the weights to (-output-weights argument 2 of 2) (sub-option of -ribbon-constrained)"
    inputBinding:
      position: 14
  - id: output_weights_text
    type:
      - 'null'
      - string
    doc: "write the voxel weights for all vertices to a text file: output - the output text filename (sub-option of -ribbon-constrained)"
    inputBinding:
      position: 15
      prefix: -output-weights-text
  - id: myelin_ribbon_roi
    type:
      - 'null'
      - File
    doc: "an roi volume of the cortical ribbon for this hemisphere (-myelin-style argument 1 of 3)"
    inputBinding:
      position: 16
      prefix: -myelin-style
  - id: myelin_thickness
    type:
      - 'null'
      - File
    doc: "a metric file of cortical thickness (-myelin-style argument 2 of 3)"
    inputBinding:
      position: 17
  - id: myelin_sigma
    type:
      - 'null'
      - float
    doc: "gaussian kernel in mm for weighting voxels within range (-myelin-style argument 3 of 3)"
    inputBinding:
      position: 18
  - id: legacy_bug
    type:
      - 'null'
      - boolean
    doc: "emulate old v1.2.3 and earlier code that didn't follow a cylinder cutoff (sub-option of -myelin-style)"
    inputBinding:
      position: 19
      prefix: -legacy-bug
  - id: subvol_select
    type:
      - 'null'
      - string
    doc: "select a single subvolume to map: the subvolume number or name"
    inputBinding:
      position: 20
      prefix: -subvol-select
outputs:
  - id: output_metric
    type: File
    doc: "the output metric file"
    outputBinding:
      glob: $(inputs.metric_out)
  - id: weights_volume
    type:
      - 'null'
      - File
    doc: "volume to write the weights to"
    outputBinding:
      glob: $(inputs.output_weights_out)
  - id: weights_text
    type:
      - 'null'
      - File
    doc: "the output text filename"
    outputBinding:
      glob: $(inputs.output_weights_text)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
