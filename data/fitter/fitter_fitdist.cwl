cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fitter
  - fitdist
label: fitter_fitdist
doc: "Fit the values of one column of a delimited text file to scipy distributions
  and report the best-fitting one. Writes a summary plot (TAG.png) and the best fit
  (TAG.log).\n\nTool homepage: https://github.com/cokelaer/fitter"
inputs:
  - id: filename
    type: File
    doc: Input delimited text file with one number per row in the chosen column
    inputBinding:
      position: 1
  - id: column_number
    type:
      - 'null'
      - int
    doc: Column to fit (1-based, default 1)
    inputBinding:
      position: 0
      prefix: --column-number
  - id: delimiter
    type:
      - 'null'
      - string
    doc: Column delimiter (default ",")
    inputBinding:
      position: 0
      prefix: --delimiter
  - id: distributions
    type:
      - 'null'
      - string
    doc: Comma-separated list of distributions to test (default gamma,beta)
    inputBinding:
      position: 0
      prefix: --distributions
  - id: tag
    type: string
    default: fitter
    doc: Tag to name output files (default fitter)
    inputBinding:
      position: 0
      prefix: --tag
  - id: no_progress
    type:
      - 'null'
      - boolean
    doc: Do not show the progress bar
    inputBinding:
      position: 0
      prefix: --no-progress
  - id: no_verbose
    type:
      - 'null'
      - boolean
    doc: Do not print messages
    inputBinding:
      position: 0
      prefix: --no-verbose
outputs:
  - id: summary_plot
    type: File
    doc: Plot of the fitted distributions
    outputBinding:
      glob: $(inputs.tag).png
  - id: best_fit_log
    type: File
    doc: Log with the best-fitting distribution and its parameters
    outputBinding:
      glob: $(inputs.tag).log
  - id: stdout
    type: stdout
    doc: Summary table of the fitted distributions
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fitter:1.4.1--pyh5e36f6f_0
stdout: fitter_fitdist.out
