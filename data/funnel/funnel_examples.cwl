cwlVersion: v1.2
class: CommandLineTool
baseCommand: full-hello
label: funnel_examples
doc: "A simple hello world example that demonstrates the full CWL functionality.\n\
  \nTool homepage: https://ohsu-comp-bio.github.io/funnel/"
inputs:
  - id: message
    type:
      - 'null'
      - string
    doc: The message to print.
    inputBinding:
      position: 101
      prefix: --message
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
    doc: An optional output file to write the message to.
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/funnel:0.9.0--0
