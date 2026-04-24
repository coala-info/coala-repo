cwlVersion: v1.2
class: CommandLineTool
baseCommand: scHicPlotConsensusMatrices
label: schicexplorer_scHicPlotConsensusMatrices
doc: "Plot consensus matrices from scool files.\n\nTool homepage: https://github.com/joachimwolff/scHiCExplorer"
inputs:
  - id: chromosomes
    type:
      - 'null'
      - type: array
        items: string
    doc: List of to be plotted chromosomes
    inputBinding:
      position: 101
      prefix: --chromosomes
  - id: color_map
    type:
      - 'null'
      - string
    doc: 'Color map to use for the heatmap. Available values can be seen here: http://matplotlib.org/examples/color/colormaps_reference.html'
    inputBinding:
      position: 101
      prefix: --colorMap
  - id: dpi
    type:
      - 'null'
      - int
    doc: The dpi of the plot.
    inputBinding:
      position: 101
      prefix: --dpi
  - id: font_size
    type:
      - 'null'
      - int
    doc: Fontsize in the plot for x and y axis.
    inputBinding:
      position: 101
      prefix: --fontsize
  - id: individual_scale
    type:
      - 'null'
      - boolean
    doc: Use an individual value range for all cluster consensus matrices. If 
      not set, the same scale is applied to all.
    inputBinding:
      position: 101
      prefix: --individual_scale
  - id: log1p
    type:
      - 'null'
      - boolean
    doc: Apply log1p operation to plot the matrices.
    inputBinding:
      position: 101
      prefix: --log1p
  - id: matrix
    type: File
    doc: The consensus matrix created by scHicConsensusMatrices
    inputBinding:
      position: 101
      prefix: --matrix
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: Do not plot a header.
    inputBinding:
      position: 101
      prefix: --no_header
  - id: region
    type:
      - 'null'
      - string
    doc: Region to be plotted for each consensus matrix. Mutual exclusion with 
      the usage of --chromosomes parameter
    inputBinding:
      position: 101
      prefix: --region
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads. Using the python multiprocessing module.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: out_file_name
    type:
      - 'null'
      - File
    doc: File name to save the resulting cluster profile.
    outputBinding:
      glob: $(inputs.out_file_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/schicexplorer:7--py_0
