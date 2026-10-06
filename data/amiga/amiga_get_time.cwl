cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - amiga
  - get_time
label: amiga_get_time
doc: "Get time at which OD reaches a certain value\n\nTool homepage: https://github.com/firasmidani/amiga"
inputs:
  - id: gp_data
    type: File
    doc: "GP data file from amiga fit --save-gp-data"
    inputBinding:
      position: 1
      prefix: --gp-data
  - id: summary
    type: File
    doc: "Summary file from the same amiga fit run; the result is added to it as a new column"
    inputBinding:
      position: 1
      prefix: --summary
  - id: threshold
    type: float
    doc: "OD value to reach"
    inputBinding:
      position: 1
      prefix: --threshold
  - id: curve_format
    type: ['null', {type: enum, symbols: [OD_Data, OD_Fit, GP_Input, GP_Output, OD_Growth_Fit, OD_Growth_Data, GP_Derivative]}]
    doc: "Curve used to find the time (default OD_Growth_Fit)"
    inputBinding:
      position: 1
      prefix: --curve-format
outputs:
  - id: updated_summary
    type: File
    doc: Summary file with an added column holding the time at which the curve reaches the threshold
    outputBinding:
      glob: $(inputs.summary.basename)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.summary)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amiga:3.0.4--pyhdfd78af_1
