cwlVersion: v1.2
class: CommandLineTool
baseCommand: octopusv_stat
label: octopusv_stat
doc: "Analyze a single SVCF file and generate comprehensive statistics.\n\nTool homepage:
  https://github.com/ylab-hi/octopusV"
inputs:
  - id: input_file
    type: File
    doc: Input SVCF file to analyze.
    inputBinding:
      position: 1
  - id: max_size
    type:
      - 'null'
      - int
    doc: Maximum SV size to consider.
    inputBinding:
      position: 102
      prefix: --max-size
  - id: min_size
    type:
      - 'null'
      - int
    doc: Minimum SV size to consider.
    default: 50
    inputBinding:
      position: 102
      prefix: --min-size
  - id: report
    type:
      - 'null'
      - boolean
    doc: Generate an HTML report.
    inputBinding:
      position: 102
      prefix: --report
outputs:
  - id: output_file
    type: File
    doc: Output file for statistics.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/octopusv:0.3.0--pyhdfd78af_0
