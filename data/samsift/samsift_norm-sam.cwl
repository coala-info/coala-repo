cwlVersion: v1.2
class: CommandLineTool
baseCommand: samsift-norm-sam
label: samsift_norm-sam
doc: "Normalize SAM in order to faciliate SAM files comparison\n\nTool homepage: https://github.com/karel-brinda/samsift"
inputs:
  - id: ignored_tags
    type:
      - 'null'
      - type: array
        items: string
    doc: ignored tags
    inputBinding:
      position: 1
      prefix: -T
  - id: skip_headers
    type:
      - 'null'
      - boolean
    doc: skip SAM headers
    inputBinding:
      position: 2
      prefix: -H
  - id: input_file
    type:
      - 'null'
      - File
    doc: "input SAM/BAM file [-]"
    inputBinding:
      position: 3
      prefix: -i
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: "output SAM/BAM file [-]"
    inputBinding:
      position: 4
      prefix: -o
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Normalized SAM/BAM file
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: stdout
    type: stdout
    doc: Standard output (normalized SAM when no output file is given)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samsift:0.3.1--pyhdfd78af_0
stdout: samsift_norm-sam.out
