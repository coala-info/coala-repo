cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -volume-stats
label: connectome-workbench_wb_command_volume-stats
doc: "Spatial statistics on a volume file. For each subvolume of the input, a single number is printed, resulting from the specified reduction or percentile operation. Use -subvolume to only give output for a single subvolume. Use -roi to consider only the data within a region. Exactly one of -reduce or -percentile must be specified.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: volume_in
    type: File
    doc: the input volume
    inputBinding:
      position: 1
  - id: reduce
    type:
      - 'null'
      - string
    doc: 'use a reduction operation: MAX, MIN, INDEXMAX, INDEXMIN, SUM, PRODUCT,
      MEAN, STDEV, SAMPSTDEV, VARIANCE, TSNR, COV, MEDIAN, MODE, COUNT_NONZERO'
    inputBinding:
      position: 2
      prefix: -reduce
  - id: percentile
    type:
      - 'null'
      - float
    doc: give the value at a percentile
    inputBinding:
      position: 2
      prefix: -percentile
  - id: subvolume
    type:
      - 'null'
      - string
    doc: only display output for one subvolume (number or name)
    inputBinding:
      position: 2
      prefix: -subvolume
  - id: roi
    type:
      - 'null'
      - File
    doc: only consider data inside an roi, given as a volume file
    inputBinding:
      position: 3
      prefix: -roi
  - id: match_maps
    type:
      - 'null'
      - boolean
    doc: with roi, each subvolume of input uses the corresponding subvolume from the roi file
    inputBinding:
      position: 4
      prefix: -match-maps
  - id: show_map_name
    type:
      - 'null'
      - boolean
    doc: print map index and name before each output
    inputBinding:
      position: 5
      prefix: -show-map-name
  - id: output_name
    type:
      - 'null'
      - string
    doc: name of the file that receives the standard output
    default: volume-stats.txt
outputs:
  - id: stats
    type: File
    doc: one number per subvolume
    outputBinding:
      glob: $(inputs.output_name)
stdout: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
