cwlVersion: v1.2
class: CommandLineTool
baseCommand: lefse2circlader.py
label: lefse_lefse2circlader.py
doc: "Convert LEfSe output to Circlader input.\n\nTool homepage: https://github.com/SegataLab/lefse"
inputs:
  - id: input_file
    type: File
    doc: 'the LEfSe result file'
    inputBinding:
      position: 1
  - id: output_file
    type: string
    doc: 'the output file'
    inputBinding:
      position: 2
  - id: levels_with_label
    type:
      - 'null'
      - int
    doc: 'levels with label'
    inputBinding:
      position: 3
      prefix: -l
outputs:
  - id: output_file_out
    type: File
    doc: 'The Circlader input file'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lefse:1.1.2--pyhdfd78af_0
