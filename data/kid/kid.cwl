cwlVersion: v1.2
class: CommandLineTool
baseCommand: kid
label: kid
doc: "Expand a Kid template file.\n\nTool homepage: https://github.com/zhihu/kids"
inputs:
  - id: input_file
    type: File
    doc: filename of the Kid template to be processed or "-" for reading the 
      template from stdin.
    inputBinding:
      position: 1
  - id: template_args
    type:
      - 'null'
      - type: array
        items: string
    doc: key=value or other arguments passed to the template.
    inputBinding:
      position: 2
  - id: output_encoding
    type:
      - 'null'
      - string
    doc: Specify the output character encoding.
    default: utf-8
    inputBinding:
      position: 103
      prefix: --encoding
  - id: server
    type:
      - 'null'
      - string
    doc: Specify the server address if you want to start the HTTP server. 
      Instead of the Kid template, you can specify a base directory.
    inputBinding:
      position: 103
      prefix: --server
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Specify the output file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kid:0.9.6--py27_1
