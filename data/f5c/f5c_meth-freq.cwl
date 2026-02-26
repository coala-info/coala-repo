cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - f5c
  - meth-freq
label: f5c_meth-freq
doc: "Calculate methylation frequency from methylation calls\n\nTool homepage: https://github.com/hasindu2008/f5c"
inputs:
  - id: call_threshold
    type:
      - 'null'
      - float
    doc: call threshold for the log likelihood ratio. Default is 2.5.
    default: 2.5
    inputBinding:
      position: 101
      prefix: -c
  - id: input_file
    type: File
    doc: input file. Read from stdin if not specified
    inputBinding:
      position: 101
      prefix: -i
  - id: split_groups
    type:
      - 'null'
      - boolean
    doc: split groups
    inputBinding:
      position: 101
      prefix: -s
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
