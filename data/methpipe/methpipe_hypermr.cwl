cwlVersion: v1.2
class: CommandLineTool
baseCommand: hypermr
label: methpipe_hypermr
doc: "A program for segmenting DNA methylation data\n\nTool homepage: https://github.com/smithlabcode/methpipe"
inputs:
  - id: input_file
    type: File
    doc: Input CpG BED file
    inputBinding:
      position: 1
  - id: desert_size
    type:
      - 'null'
      - int
    doc: desert size
    default: 1000
    inputBinding:
      position: 102
      prefix: -desert
  - id: max_iterations
    type:
      - 'null'
      - int
    doc: max iterations
    default: 10
    inputBinding:
      position: 102
      prefix: -itr
  - id: min_meth
    type:
      - 'null'
      - float
    doc: min cumulative methylation level in HypeMR
    default: 4.0
    inputBinding:
      position: 102
      prefix: -min-meth
  - id: params_in
    type:
      - 'null'
      - File
    doc: HMM parameters file
    inputBinding:
      position: 102
      prefix: -params-in
  - id: tolerance
    type:
      - 'null'
      - float
    doc: Tolerance
    default: 0.0
    inputBinding:
      position: 102
      prefix: -tolerance
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print more run info
    inputBinding:
      position: 102
      prefix: -verbose
  - id: viterbi
    type:
      - 'null'
      - boolean
    doc: Use Viterbi decoding
    inputBinding:
      position: 102
      prefix: -viterbi
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file (BED format)
    outputBinding:
      glob: $(inputs.output_file)
  - id: scores_output
    type:
      - 'null'
      - File
    doc: output file for posterior scores
    outputBinding:
      glob: $(inputs.scores_output)
  - id: params_out
    type:
      - 'null'
      - File
    doc: HMM parameters file
    outputBinding:
      glob: $(inputs.params_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methpipe:5.0.1--h76b9af2_6
