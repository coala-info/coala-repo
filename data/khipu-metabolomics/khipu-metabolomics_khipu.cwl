cwlVersion: v1.2
class: CommandLineTool
baseCommand: khipu
label: khipu-metabolomics_khipu
doc: "annotating metabolomics features to empCpds\n\nTool homepage: https://github.com/shuzhao-li/khipu"
inputs:
  - id: end
    type:
      - 'null'
      - int
    doc: end column for intensity in input table
    inputBinding:
      position: 101
      prefix: --end
  - id: input
    type:
      - 'null'
      - File
    doc: input file as feature table
    inputBinding:
      position: 101
      prefix: --input
  - id: mode
    type:
      - 'null'
      - string
    doc: mode of ionization, pos or neg
    inputBinding:
      position: 101
      prefix: --mode
  - id: ppm
    type:
      - 'null'
      - float
    doc: mass precision in ppm (part per million), same as mz_tolerance_ppm
    inputBinding:
      position: 101
      prefix: --ppm
  - id: regular
    type:
      - 'null'
      - boolean
    doc: toggle on if there is no isotopic labeled sample
    inputBinding:
      position: 101
      prefix: --regular
  - id: rtol
    type:
      - 'null'
      - float
    doc: tolerance of retention time match, arbitrary unit dependent on 
      preprocessing tool
    inputBinding:
      position: 101
      prefix: --rtol
  - id: start
    type:
      - 'null'
      - int
    doc: start column for intensity in input table
    inputBinding:
      position: 101
      prefix: --start
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: prefix of output files
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/khipu-metabolomics:2.0.4--pyhdfd78af_0
