cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bakdrive
  - fmt_only
label: bakdrive_fmt_only
doc: "After-FMT or ADT simulation following the GLV model. The input is a file prefix;
  bakdrive reads <prefix>_micom_input.tsv, <prefix>_ko.tsv and <prefix>_growth_rate.tsv.\n
  \nTool homepage: https://gitlab.com/treangenlab/bakdrive"
inputs:
  - id: input_file
    type: File
    doc: The <prefix>_micom_input.tsv file; <prefix>_ko.tsv and <prefix>_growth_rate.tsv
      must sit beside it. The prefix is passed to the tool.
    secondaryFiles:
      - pattern: ${return self.basename.replace(/_micom_input\.tsv$/, '') + '_ko.tsv'}
        required: true
      - pattern: ${return self.basename.replace(/_micom_input\.tsv$/, '') + '_growth_rate.tsv'}
        required: true
    inputBinding:
      position: 1
      valueFrom: $(self.path.replace(/_micom_input\.tsv$/, ''))
  - id: prefix
    type:
      - 'null'
      - string
    doc: Output file prefix
    inputBinding:
      position: 102
      prefix: --prefix
  - id: strength
    type:
      - 'null'
      - float
    doc: Threshold of Interaction Strength
    inputBinding:
      position: 102
      prefix: --strength
  - id: output_path
    type: string
    doc: Output folder
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type: Directory
    doc: Output folder
    outputBinding:
      glob: $(inputs.output_path)
  - id: prefix_files
    type:
      type: array
      items: File
    doc: fmt_abd_<prefix>.txt and fmt_timepoints_<prefix>.txt
    outputBinding:
      glob: $(inputs.output_path)/fmt_*_$(inputs.prefix || 'fmt_only_output').txt
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bakdrive:1.0.4--hdfd78af_0
