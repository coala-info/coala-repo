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
  - id: index_file
    type:
      - 'null'
      - File
    doc: Index file written beside the input (<input>.idx)
    outputBinding:
      glob: $(inputs.input_file.basename).idx
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slow5tools:1.4.0--hee927d3_0
stdout: slow5tools_index.out
