cwlVersion: v1.2
class: CommandLineTool
baseCommand: woltka normalize
label: woltka_normalize
doc: "Normalize a profile to fractions and/or by feature sizes.\n\nTool homepage:
  https://github.com/qiyunzhu/woltka"
inputs:
  - id: digits
    type:
      - 'null'
      - int
    doc: Round values to this number of digits after the decimal point. If 
      omitted, will keep decimal precision of input profile.  [0<=x<=10]
    inputBinding:
      position: 101
      prefix: --digits
  - id: input_file
    type: File
    doc: Path to input profile.
    inputBinding:
      position: 101
      prefix: --input
  - id: scale
    type:
      - 'null'
      - string
    doc: Scale values by this factor. Accepts "k", "M" suffixes.
    inputBinding:
      position: 101
      prefix: --scale
  - id: sizes_file
    type:
      - 'null'
      - File
    doc: Path to mapping of feature sizes, by which values will be divided. If 
      omitted, will divide values by sum per sample.
    inputBinding:
      position: 101
      prefix: --sizes
outputs:
  - id: output_file
    type: File
    doc: Path to output profile.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/woltka:0.1.7--pyhdfd78af_0
