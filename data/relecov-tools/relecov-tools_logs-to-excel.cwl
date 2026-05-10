cwlVersion: v1.2
class: CommandLineTool
baseCommand: relecov-tools logs-to-excel
label: relecov-tools_logs-to-excel
doc: "Creates a merged xlsx and Json report from all the log summary jsons given as
  input\n\nTool homepage: https://github.com/BU-ISCIII/relecov-tools"
inputs:
  - id: files
    type:
      type: array
      items: string
    doc: Paths to log_summary.json files to merge into xlsx file, called once 
      per file
    inputBinding:
      position: 101
      prefix: --files
  - id: lab_code
    type:
      - 'null'
      - string
    doc: Only merge logs from target laboratory in log-summary.json files
    inputBinding:
      position: 101
      prefix: --lab_code
  - id: output_dir_path
    type: Directory
    doc: Output or path parameter `output_dir_path`
    inputBinding:
      position: 102
      prefix: --output-dir
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory where the generated output will be saved
    outputBinding:
      glob: $(inputs.output_dir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relecov-tools:1.7.4--pyhdfd78af_0
