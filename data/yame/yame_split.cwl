cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - yame
  - split
label: yame_split
doc: "Split a cx file into multiple files based on sample names.\n\nTool homepage:
  https://github.com/zhou-lab/YAME"
inputs:
  - id: input_cx_file
    type: File
    secondaryFiles:
      - pattern: .idx
        required: false
    doc: Input cx file
    inputBinding:
      position: 1
  - id: output_prefix
    type: string
    doc: Prefix for output files
    inputBinding:
      position: 2
  - id: sample_name_list
    type:
      - 'null'
      - File
    doc: sample name list (file with one name per line; names the output files)
    inputBinding:
      position: 103
      prefix: -s
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_prefix_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in output_prefix
    outputBinding:
      glob: $(inputs.output_prefix)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yame:1.8--ha83d96e_0
stdout: yame_split.out
