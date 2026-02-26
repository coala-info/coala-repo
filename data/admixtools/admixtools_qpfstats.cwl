cwlVersion: v1.2
class: CommandLineTool
baseCommand: qpfstats
label: admixtools_qpfstats
doc: "Compute f-statistics for AdmixTools\n\nTool homepage: https://github.com/DReichLab/AdmixTools"
inputs:
  - id: input_file
    type: File
    doc: Input file
    inputBinding:
      position: 1
  - id: base_value
    type:
      - 'null'
      - string
    doc: use <va> as base value
    inputBinding:
      position: 102
      prefix: -b
  - id: do_analysis
    type:
      - 'null'
      - boolean
    doc: toggle doAnalysis ON
    inputBinding:
      position: 102
      prefix: -x
  - id: g_option
    type:
      - 'null'
      - string
    doc: g option
    inputBinding:
      position: 102
      prefix: -g
  - id: lambda_scale
    type:
      - 'null'
      - float
    doc: use <val> as lambda scale
    inputBinding:
      position: 102
      prefix: -l
  - id: parameter_file
    type:
      - 'null'
      - File
    doc: use parameters from <file>
    inputBinding:
      position: 102
      prefix: -p
  - id: seed
    type:
      - 'null'
      - int
    doc: use <val> as seed
    inputBinding:
      position: 102
      prefix: -s
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: toggle verbose mode ON
    inputBinding:
      position: 102
      prefix: -V
outputs:
  - id: output_option
    type:
      - 'null'
      - File
    doc: output option
    outputBinding:
      glob: $(inputs.output_option)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/admixtools:8.0.2--h75d7a4a_0
