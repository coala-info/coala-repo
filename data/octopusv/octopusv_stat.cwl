cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - octopusv
  - stat
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
  - id: output_file_path
    type: string
    doc: PATH     Output file for statistics. [required]    │
    inputBinding:
      position: 103
      prefix: --output-file
outputs:
  - id: output_file
    type: File
    doc: Output file for statistics.
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: report_html
    type:
      - 'null'
      - File
    doc: HTML report written when report is set (output file name with the extension replaced by .html)
    outputBinding:
      glob: "$(inputs.output_file_path.replace(/\\.[^.\\/]*$/, '') + '.html')"
  - id: report_plots
    type:
      type: array
      items: File
    doc: Plot files written when report is set (output file stem followed by _chromosome_distribution, _sv_sizes and _sv_types as png and svg)
    outputBinding:
      glob: "$(inputs.output_file_path.replace(/\\.[^.\\/]*$/, '') + '_*')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/octopusv:0.3.0--pyhdfd78af_0
