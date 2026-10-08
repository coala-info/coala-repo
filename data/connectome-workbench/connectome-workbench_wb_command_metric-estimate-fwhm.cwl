cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-metric-estimate-fwhm'
label: connectome-workbench_wb_command_metric-estimate-fwhm
doc: "Estimate FWHM smoothness of a metric file. Estimates the smoothness of the metric columns, printing the estimates to standard output. These estimates ignore variation in vertex spacing.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: surface
    type: File
    doc: the surface to use for distance and neighbor information
    inputBinding:
      position: 1
  - id: metric_in
    type: File
    doc: the input metric
    inputBinding:
      position: 2
  - id: roi
    type:
      - 'null'
      - File
    doc: use only data within an ROI, as a metric file
    inputBinding:
      position: 3
      prefix: '-roi'
  - id: column
    type:
      - 'null'
      - string
    doc: select a single column to estimate smoothness of (number or name)
    inputBinding:
      position: 3
      prefix: '-column'
  - id: whole_file
    type:
      - 'null'
      - boolean
    doc: estimate for the whole file at once, not each column separately
    inputBinding:
      position: 4
      prefix: '-whole-file'
  - id: demean
    type:
      - 'null'
      - boolean
    doc: 'with whole_file: subtract the mean image before estimating smoothness'
    inputBinding:
      position: 5
      prefix: '-demean'
  - id: output_name
    type:
      - 'null'
      - string
    doc: name of the file that receives the standard output
    default: metric-fwhm.txt
outputs:
  - id: fwhm_estimates
    type: File
    doc: the printed smoothness estimates
    outputBinding:
      glob: $(inputs.output_name)
stdout: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
