cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - f5c
  - freq-merge
label: f5c_freq-merge
doc: "Merge multiple methylation frequency files into one.\n\nTool homepage: https://github.com/hasindu2008/f5c"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input methylation frequency files (TSV format)
    inputBinding:
      position: 1
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file. Write to stdout if not specified
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/f5c:1.6--hee927d3_0
