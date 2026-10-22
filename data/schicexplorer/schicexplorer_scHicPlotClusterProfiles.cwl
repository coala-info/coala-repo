cwlVersion: v1.2
class: CommandLineTool
baseCommand: scHicPlotClusterProfiles
label: schicexplorer_scHicPlotClusterProfiles
doc: "Plots the cluster profiles: the ratio of short range to long range contacts of the cells of each cluster.\n\nTool homepage: https://github.com/joachimwolff/scHiCExplorer"
inputs:
  - id: matrix
    type: File
    doc: "The single cell Hi-C interaction matrices to investigate. Needs to be in scool format"
    inputBinding:
      position: 101
      prefix: --matrix
  - id: clusters
    type: File
    doc: "Text file which contains per matrix the associated cluster."
    inputBinding:
      position: 101
      prefix: --clusters
  - id: chromosomes
    type:
      - 'null'
      - type: array
        items: string
    doc: "List of to be plotted chromosomes"
    inputBinding:
      position: 101
      prefix: --chromosomes
  - id: maximal_distance
    type:
      - 'null'
      - int
    doc: "Maximal distance in bases to consider for ratio computation. (default: 50000000)"
    inputBinding:
      position: 101
      prefix: --maximalDistance
  - id: distance_short_range
    type:
      - 'null'
      - int
    doc: "Distance which should be considered as lower distance for svl ordering. Default 2MB. (default: 2000000)"
    inputBinding:
      position: 101
      prefix: --distanceShortRange
  - id: distance_long_range
    type:
      - 'null'
      - int
    doc: "Distance which should be considered as upper distance for svl ordering. Default 12MB. (default: 12000000)"
    inputBinding:
      position: 101
      prefix: --distanceLongRange
  - id: order_by
    type:
      - 'null'
      - string
    doc: "Order of the clusters (svl, orderByFile; default: svl)"
    inputBinding:
      position: 101
      prefix: --orderBy
  - id: fontsize
    type:
      - 'null'
      - int
    doc: "Fontsize in the plot for x and y axis. (default: 10)"
    inputBinding:
      position: 101
      prefix: --fontsize
  - id: rotation_x
    type:
      - 'null'
      - int
    doc: "Rotation in degrees for the labels of x axis. (default: 0)"
    inputBinding:
      position: 101
      prefix: --rotationX
  - id: ticks
    type:
      - 'null'
      - boolean
    doc: "Plot the cluster names as ticks. Use legend if they overlap."
    inputBinding:
      position: 101
      prefix: --ticks
  - id: legend
    type:
      - 'null'
      - boolean
    doc: "Plot the cluster names as legend. Might be helpful if the ticks overlap."
    inputBinding:
      position: 101
      prefix: --legend
  - id: dpi
    type:
      - 'null'
      - int
    doc: "The dpi of the plot. (default: 300)"
    inputBinding:
      position: 101
      prefix: --dpi
  - id: color_map
    type:
      - 'null'
      - string
    doc: "Color map to use for the heatmap. (default: RdYlBu_r)"
    inputBinding:
      position: 101
      prefix: --colorMap
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads. Using the python multiprocessing module."
    inputBinding:
      position: 101
      prefix: --threads
  - id: out_file_name_path
    type:
      - 'null'
      - string
    doc: "File name to save the resulting cluster profile. (default: clusters_profile.png)"
    inputBinding:
      position: 102
      prefix: --outFileName
outputs:
  - id: out_file_name
    type:
      - 'null'
      - File
    doc: "Cluster profile plot"
    outputBinding:
      glob: "$(inputs.out_file_name_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/schicexplorer:7--py_0
