cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - generatestatetrees
label: decifer_generatestatetrees
doc: "Generate the DeCiFer state trees for a set of copy-number states (from cn_states
  files, or all states up to -maxXY copies and -maxCN events).\n\nTool homepage: https://github.com/raphael-group/decifer"
inputs:
  - id: input_state_trees
    type:
      - 'null'
      - File
    doc: Input state tree file (-S); its state trees are read first and kept in
      the output
    inputBinding:
      position: 1
      prefix: -S
  - id: output_state_trees
    type: string
    doc: Output state tree file (-SS)
    default: state_trees.txt
    inputBinding:
      position: 1
      prefix: -SS
  - id: max_cn
    type:
      - 'null'
      - int
    doc: 'Maximum number of copy number events (default: 2); used when no
      cn_states file is given'
    inputBinding:
      position: 1
      prefix: -maxCN
  - id: max_xy
    type:
      - 'null'
      - int
    doc: 'Maximum number of maternal/paternal copies (default: 2); used when no
      cn_states file is given'
    inputBinding:
      position: 1
      prefix: -maxXY
  - id: cn_states
    type:
      - 'null'
      - type: array
        items: File
    doc: Files listing copy-number states, one site per line (e.g. 2,2;1,1),
      such as cn_states.txt from vcf_2_decifer.py
    inputBinding:
      position: 2
outputs:
  - id: state_trees
    type: File
    doc: State tree file for the --statetrees option of decifer
    outputBinding:
      glob: $(inputs.output_state_trees)
  - id: log
    type: stderr
    doc: Progress log (one line per copy-number state set)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/decifer:2.1.4--py312hf731ba3_4
stderr: decifer_generatestatetrees.log
