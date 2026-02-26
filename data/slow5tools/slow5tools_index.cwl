cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - slow5tools
  - index
label: slow5tools_index
doc: "Create a slow5 or blow5 index file.\n\nTool homepage: https://github.com/hasindu2008/slow5tools"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: SLOW5 or BLOW5 file to index
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slow5tools:1.4.0--hee927d3_0
stdout: slow5tools_index.out
