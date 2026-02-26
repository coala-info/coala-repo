cwlVersion: v1.2
class: CommandLineTool
baseCommand: fancplot
label: fanc_fancplot
doc: "fancplot plotting tool for fanc\n\nTool homepage: https://github.com/vaquerizaslab/fanc"
inputs:
  - id: regions
    type:
      type: array
      items: string
    doc: List of region selectors (<chr>:<start>-<end>) or files with region 
      information (BED, GTF, ...).
    inputBinding:
      position: 1
  - id: invert_x
    type:
      - 'null'
      - boolean
    doc: Invert x-axis for this plot
    inputBinding:
      position: 102
      prefix: --invert-x
  - id: name
    type:
      - 'null'
      - string
    doc: Plot name to be used as prefix when plotting multiple regions. Is 
      ignored for single region and interactive plot.
    inputBinding:
      position: 102
      prefix: --name
  - id: plot
    type:
      - 'null'
      - string
    doc: New plot, type will be chosen automatically by file type, unless "-t" 
      is provided.
    inputBinding:
      position: 102
      prefix: --plot
  - id: script
    type:
      - 'null'
      - File
    doc: Use a script file to define plot.
    inputBinding:
      position: 102
      prefix: --script
  - id: tick_locations
    type:
      - 'null'
      - type: array
        items: string
    doc: Manually define the locations of the tick labels on the genome axis.
    inputBinding:
      position: 102
      prefix: --tick-locations
  - id: width
    type:
      - 'null'
      - float
    doc: Width of the figure in inches.
    default: 4.0
    inputBinding:
      position: 102
      prefix: --width
  - id: window_size
    type:
      - 'null'
      - int
    doc: Plotting region size in base pairs. If provided, the actual size of the
      given region is ignored and instead a region <chromosome>:<region center -
      window size/2> - <region center + window size/2> will be plotted.
    inputBinding:
      position: 102
      prefix: --window-size
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Suppresses interactive plotting window and redirects plot to file. 
      Specify path to file when plotting a single region, and path to a folder 
      for plotting multiple regions.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
