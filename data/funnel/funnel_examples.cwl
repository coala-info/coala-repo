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
    default: Hello World!
    inputBinding:
      position: 101
      prefix: --message
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: An optional output file to write the message to.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/funnel:0.9.0--0
