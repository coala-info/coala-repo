cwlVersion: v1.2
class: CommandLineTool
baseCommand: EvoFoldV2
label: evofold2_EvoFoldV2
doc: "EvoFold predicts and scores secondary structures in multiple sequence alignments. Output columns: seqId beginPos endPos basePairCount strCykProb bgCykProb strProb bgProb cykScore score strPostProb fold posScore.\n\nTool homepage: https://github.com/jakob-skou-pedersen/phy"
inputs:
  - id: config_file_path
    type:
      - 'null'
      - string
    doc: "Path to EvoFold configuration files (the image ships them in /usr/local/include/EvoFoldConfig/)"
    default: "/usr/local/include/EvoFoldConfig/"
    inputBinding:
      position: 1
      prefix: -c
  - id: complete_file
    type:
      - 'null'
      - string
    doc: "Output complete structure predictions for each input element in addition to the sub-structures"
    inputBinding:
      position: 2
      prefix: -f
  - id: anno_name
    type:
      - 'null'
      - string
    doc: "Name of annotation to use (see annoMap file for definition of annotation symbols; * can be used as wildcard); adds constraints on the predicted structure"
    inputBinding:
      position: 3
      prefix: -n
  - id: decimals
    type:
      - 'null'
      - int
    doc: "Output precision of score (default 5)"
    inputBinding:
      position: 4
      prefix: --decimals
  - id: output_file
    type:
      - 'null'
      - string
    doc: "Output file (default is stdout)"
    inputBinding:
      position: 5
      prefix: -o
  - id: alignment_ama
    type: File
    doc: "Multiple alignment in ama format"
    inputBinding:
      position: 100
  - id: tree_newick
    type: File
    doc: "Phylogenetic tree in Newick format"
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Predictions when no output file is given
  - id: predictions
    type:
      - 'null'
      - File
    doc: "Tabular structure predictions"
    outputBinding:
      glob: $(inputs.output_file)
  - id: complete_predictions
    type:
      - 'null'
      - File
    doc: "Complete structure predictions"
    outputBinding:
      glob: $(inputs.complete_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/evofold2:0.1--0
stdout: evofold2_EvoFoldV2.out
