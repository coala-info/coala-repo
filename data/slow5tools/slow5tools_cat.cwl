cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - slow5tools
  - cat
label: slow5tools_cat
doc: "Quickly concatenate SLOW5/BLOW5 files of same type (same header, extension,
  compression)\n\nTool homepage: https://github.com/hasindu2008/slow5tools"
inputs:
  - id: slow5_file_dir
    type:
      - 'null'
      - File
    doc: SLOW5/BLOW5 file or directory to concatenate
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
    doc: output to FILE
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slow5tools:1.4.0--hee927d3_0
