cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -volume-estimate-fwhm
label: connectome-workbench_wb_command_volume-estimate-fwhm
doc: "Estimates the smoothness of the input volume in X, Y, and Z directions separately, printing the estimates to standard output, in mm as FWHM. If -subvolume or -whole-file are not specified, each subvolume is estimated and displayed separately.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: volume
    type: File
    doc: "the input volume"
    inputBinding:
      position: 1
  - id: roi
    type:
      - 'null'
      - File
    doc: "use only data within an ROI: the volume to use as an ROI"
    inputBinding:
      position: 2
      prefix: -roi
  - id: subvolume
    type:
      - 'null'
      - string
    doc: "select a single subvolume to estimate smoothness of: the subvolume number or name"
    inputBinding:
      position: 3
      prefix: -subvolume
  - id: whole_file
    type:
      - 'null'
      - boolean
    doc: "estimate for the whole file at once, not each subvolume separately"
    inputBinding:
      position: 4
      prefix: -whole-file
  - id: demean
    type:
      - 'null'
      - boolean
    doc: "subtract the mean image before estimating smoothness (sub-option of -whole-file)"
    inputBinding:
      position: 5
      prefix: -demean
  - id: output_name
    type:
      - 'null'
      - string
    doc: "name of the file that receives the standard output"
    default: "volume-estimate-fwhm.txt"
outputs:
  - id: fwhm_estimates
    type: File
    doc: "FWHM estimates in mm for X, Y and Z"
    outputBinding:
      glob: $(inputs.output_name)
stdout: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
