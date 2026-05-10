cwlVersion: v1.2
class: CommandLineTool
baseCommand: covstats
label: mimodd_covstats
doc: "Calculate coverage statistics from BCF files.\n\nTool homepage: http://sourceforge.net/projects/mimodd"
inputs:
  - id: input_file
    type: File
    doc: BCF output from varcall
    inputBinding:
      position: 1
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 101
      prefix: --output-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: redirect the output to the specified file
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimodd:0.1.9--py35_0
