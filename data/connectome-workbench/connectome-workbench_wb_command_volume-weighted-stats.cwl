cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -volume-weighted-stats
label: connectome-workbench_wb_command_volume-weighted-stats
doc: "For each subvolume of the input, a single number is printed, resulting from the specified operation. If -weight-volume is not specified, each voxel's volume is used. Use -subvolume to only give output for a single subvolume. Use -roi to consider only the data within a region. Exactly one of -mean, -stdev, -percentile or -sum must be specified.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: volume_in
    type: File
    doc: "the input volume"
    inputBinding:
      position: 1
  - id: weight_volume
    type:
      - 'null'
      - File
    doc: "use weights from a volume file: volume file containing the weights"
    inputBinding:
      position: 2
      prefix: -weight-volume
  - id: weight_match_maps
    type:
      - 'null'
      - boolean
    doc: "each subvolume of input uses the corresponding subvolume from the weights file (sub-option of -weight-volume)"
    inputBinding:
      position: 3
      prefix: -match-maps
  - id: subvolume
    type:
      - 'null'
      - string
    doc: "only display output for one subvolume: the subvolume number or name"
    inputBinding:
      position: 4
      prefix: -subvolume
  - id: roi
    type:
      - 'null'
      - File
    doc: "only consider data inside an roi: the roi, as a volume file"
    inputBinding:
      position: 5
      prefix: -roi
  - id: roi_match_maps
    type:
      - 'null'
      - boolean
    doc: "each subvolume of input uses the corresponding subvolume from the roi file (sub-option of -roi)"
    inputBinding:
      position: 6
      prefix: -match-maps
  - id: mean
    type:
      - 'null'
      - boolean
    doc: "compute weighted mean"
    inputBinding:
      position: 7
      prefix: -mean
  - id: stdev
    type:
      - 'null'
      - boolean
    doc: "compute weighted standard deviation"
    inputBinding:
      position: 8
      prefix: -stdev
  - id: sample
    type:
      - 'null'
      - boolean
    doc: "estimate population stdev from the sample (sub-option of -stdev)"
    inputBinding:
      position: 9
      prefix: -sample
  - id: percentile
    type:
      - 'null'
      - float
    doc: "compute weighted percentile: the percentile to find"
    inputBinding:
      position: 10
      prefix: -percentile
  - id: sum
    type:
      - 'null'
      - boolean
    doc: "compute weighted sum"
    inputBinding:
      position: 11
      prefix: -sum
  - id: show_map_name
    type:
      - 'null'
      - boolean
    doc: "print map index and name before each output"
    inputBinding:
      position: 12
      prefix: -show-map-name
  - id: output_name
    type:
      - 'null'
      - string
    doc: "name of the file that receives the standard output"
    default: "volume-weighted-stats.txt"
outputs:
  - id: stats
    type: File
    doc: "one number per subvolume"
    outputBinding:
      glob: $(inputs.output_name)
stdout: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
