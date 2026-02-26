cwlVersion: v1.2
class: CommandLineTool
baseCommand: kin
label: kin
doc: "Relatedness and IBD estimates\n\nTool homepage: https://github.com/DivyaratanPopli/Kinship_Inference"
inputs:
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of cores available
    inputBinding:
      position: 101
      prefix: --cores
  - id: diversity_parameter_p_0
    type:
      - 'null'
      - float
    doc: "Input p_0 parameter, if you do not want to calculate\nit from given samples
      (Keep it same as that for\nKINgaroo)"
    inputBinding:
      position: 101
      prefix: --diversity_parameter_p_0
  - id: input_location
    type: Directory
    doc: input files location
    inputBinding:
      position: 101
      prefix: --input_location
  - id: roh_file_location
    type:
      - 'null'
      - File
    doc: ROH files location
    inputBinding:
      position: 101
      prefix: --ROH_file_location
  - id: threshold
    type:
      - 'null'
      - float
    doc: "Minimum number of sites in a window for ROH\nimplementation"
    inputBinding:
      position: 101
      prefix: --threshold
outputs:
  - id: output_location
    type: Directory
    doc: Output files location
    outputBinding:
      glob: $(inputs.output_location)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kin:3.1.4--pyhdfd78af_0
