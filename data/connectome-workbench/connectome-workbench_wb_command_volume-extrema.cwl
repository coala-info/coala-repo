cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -volume-extrema
label: connectome-workbench_wb_command_volume-extrema
doc: "Finds extrema in a volume file, such that no two extrema of the same type are within <distance> of each other. The extrema are labeled as -1 for minima, 1 for maxima, 0 otherwise. If -only-maxima or -only-minima is specified, then it will ignore extrema not of the specified type. These options are mutually exclusive.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: volume_in
    type: File
    doc: "volume file to find the extrema of"
    inputBinding:
      position: 1
  - id: distance
    type: float
    doc: "the minimum distance between identified extrema of the same type"
    inputBinding:
      position: 2
  - id: volume_out
    type: string
    doc: "output - the output extrema volume"
    inputBinding:
      position: 3
  - id: presmooth
    type:
      - 'null'
      - float
    doc: "smooth the volume before finding extrema: the sigma for the gaussian smoothing kernel, in mm"
    inputBinding:
      position: 4
      prefix: -presmooth
  - id: roi
    type:
      - 'null'
      - File
    doc: "ignore values outside the selected area: the area to find extrema in"
    inputBinding:
      position: 5
      prefix: -roi
  - id: threshold_low
    type:
      - 'null'
      - float
    doc: "the largest value to consider for being a minimum (-threshold argument 1 of 2)"
    inputBinding:
      position: 6
      prefix: -threshold
  - id: threshold_high
    type:
      - 'null'
      - float
    doc: "the smallest value to consider for being a maximum (-threshold argument 2 of 2)"
    inputBinding:
      position: 7
  - id: sum_subvols
    type:
      - 'null'
      - boolean
    doc: "output the sum of the extrema subvolumes instead of each subvolume separately"
    inputBinding:
      position: 8
      prefix: -sum-subvols
  - id: consolidate_mode
    type:
      - 'null'
      - boolean
    doc: "use consolidation of local minima instead of a large neighborhood"
    inputBinding:
      position: 9
      prefix: -consolidate-mode
  - id: only_maxima
    type:
      - 'null'
      - boolean
    doc: "only find the maxima"
    inputBinding:
      position: 10
      prefix: -only-maxima
  - id: only_minima
    type:
      - 'null'
      - boolean
    doc: "only find the minima"
    inputBinding:
      position: 11
      prefix: -only-minima
  - id: subvolume
    type:
      - 'null'
      - string
    doc: "select a single subvolume to find extrema in: the subvolume number or name"
    inputBinding:
      position: 12
      prefix: -subvolume
outputs:
  - id: output_volume
    type: File
    doc: "the output extrema volume"
    outputBinding:
      glob: $(inputs.volume_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
