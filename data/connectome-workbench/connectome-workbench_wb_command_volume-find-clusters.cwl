cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -volume-find-clusters
label: connectome-workbench_wb_command_volume-find-clusters
doc: "Outputs a volume with nonzero integers for all voxels within a large enough cluster, and zeros elsewhere. The integers denote cluster membership (by default, first cluster found will use value 1, second cluster 2, etc). By default, values greater than <value-threshold> are considered to be in a cluster, use -less-than to test for values less than the threshold. To apply this as a mask to the data, or to do more complicated thresholding, see -volume-math.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: volume_in
    type: File
    doc: "the input volume"
    inputBinding:
      position: 1
  - id: value_threshold
    type: float
    doc: "threshold for data values"
    inputBinding:
      position: 2
  - id: minimum_volume
    type: float
    doc: "threshold for cluster volume, in mm^3"
    inputBinding:
      position: 3
  - id: volume_out
    type: string
    doc: "output - the output volume"
    inputBinding:
      position: 4
  - id: less_than
    type:
      - 'null'
      - boolean
    doc: "find values less than <value-threshold>, rather than greater"
    inputBinding:
      position: 5
      prefix: -less-than
  - id: roi
    type:
      - 'null'
      - File
    doc: "select a region of interest: the roi, as a volume file"
    inputBinding:
      position: 6
      prefix: -roi
  - id: subvolume
    type:
      - 'null'
      - string
    doc: "select a single subvolume: the subvolume number or name"
    inputBinding:
      position: 7
      prefix: -subvolume
  - id: size_ratio
    type:
      - 'null'
      - float
    doc: "ignore clusters smaller than a given fraction of the largest cluster in map: fraction of the largest cluster's volume"
    inputBinding:
      position: 8
      prefix: -size-ratio
  - id: distance
    type:
      - 'null'
      - float
    doc: "ignore clusters further than a given distance from the largest cluster: how far from the largest cluster a cluster can be, edge to edge, in mm"
    inputBinding:
      position: 9
      prefix: -distance
  - id: start
    type:
      - 'null'
      - int
    doc: "start labeling clusters from a value other than 1: the value to give the first cluster found"
    inputBinding:
      position: 10
      prefix: -start
outputs:
  - id: output_volume
    type: File
    doc: "the output volume"
    outputBinding:
      glob: $(inputs.volume_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
