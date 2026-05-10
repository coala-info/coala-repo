cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kmercamel
  - mssep2ms
label: kmercamel_mssep2ms
doc: "Cannot have both superstring and mask redirected from stdin.\n\nTool homepage:
  https://github.com/OndrejSladky/kmercamel/"
inputs:
  - id: mask_file
    type:
      - 'null'
      - File
    doc: input file with mask
    inputBinding:
      position: 101
      prefix: -m
  - id: superstring_file
    type:
      - 'null'
      - File
    doc: input file with superstring
    inputBinding:
      position: 101
      prefix: -s
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 102
      prefix: --output-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output for the (minone) masked superstring; if not specified, printed 
      to stdout
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmercamel:2.2.0--ha119d93_0
