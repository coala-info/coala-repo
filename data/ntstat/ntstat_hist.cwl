cwlVersion: v1.2
class: CommandLineTool
baseCommand: ntstat
label: ntstat_hist
doc: "Generates a histogram from k-mer spectrum data.\n\nTool homepage: https://github.com/bcgsc/ntStat"
inputs:
  - id: path
    type: File
    doc: k-mer spectrum file (in ntCard format)
    inputBinding:
      position: 1
  - id: config
    type:
      - 'null'
      - File
    doc: path to differential evolution config file (json)
    inputBinding:
      position: 102
      prefix: --config
  - id: no_model
    type:
      - 'null'
      - boolean
    doc: Disable model fitting
    inputBinding:
      position: 102
      prefix: --no-model
  - id: no_y_log
    type:
      - 'null'
      - boolean
    doc: plot y-axis in log scale
    inputBinding:
      position: 102
      prefix: --no-y-log
  - id: ploidy
    type:
      - 'null'
      - int
    doc: genome ploidy
    inputBinding:
      position: 102
      prefix: --ploidy
  - id: plot_range
    type:
      - 'null'
      - string
    doc: plot x-axis limits (inclusive) separated by a colon, i.e., use a:b to 
      show results in the range [a, b]. 'auto' will automatically adjust the 
      limits for better visibility.
    inputBinding:
      position: 102
      prefix: --plot-range
  - id: style
    type:
      - 'null'
      - string
    doc: matplotlib style file, url, or one of available style names
    inputBinding:
      position: 102
      prefix: --style
  - id: table_format
    type:
      - 'null'
      - string
    doc: stdout table format
    inputBinding:
      position: 102
      prefix: --table-format
  - id: title
    type:
      - 'null'
      - string
    doc: title to put on plot
    inputBinding:
      position: 102
      prefix: --title
  - id: y_log
    type:
      - 'null'
      - boolean
    doc: plot y-axis in log scale
    inputBinding:
      position: 102
      prefix: --y-log
  - id: fit_gif_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `fit_gif_path`
    inputBinding:
      position: 103
      prefix: --fit-gif
  - id: plot_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `plot_path`
    inputBinding:
      position: 104
      prefix: --plot
  - id: probs_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `probs_path`
    inputBinding:
      position: 105
      prefix: --probs
outputs:
  - id: plot
    type:
      - 'null'
      - File
    doc: path to output plot
    outputBinding:
      glob: $(inputs.plot_path)
  - id: probs
    type:
      - 'null'
      - File
    doc: path to output probabilities in csv format
    outputBinding:
      glob: $(inputs.probs_path)
  - id: fit_gif
    type:
      - 'null'
      - File
    doc: path to output model fit history animation
    outputBinding:
      glob: $(inputs.fit_gif_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ntstat:1.0.1--py311he264feb_2
