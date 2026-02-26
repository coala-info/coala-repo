cwlVersion: v1.2
class: CommandLineTool
baseCommand: augur_traits
label: augur_traits
doc: "Infer ancestral traits based on a tree.\n\nTool homepage: https://github.com/nextstrain/augur"
inputs:
  - id: branch_confidence
    type:
      - 'null'
      - type: array
        items: string
    doc: Only label state changes where the confidence percentage is above the 
      specified value.Transitions to lower confidence states will be represented
      by a "uncertain" label.
    default: []
    inputBinding:
      position: 101
      prefix: --branch-confidence
  - id: branch_labels
    type:
      - 'null'
      - type: array
        items: string
    doc: Add branch labels where there is a change in trait inferred for that 
      column. You must supply this for each column you would like to label. By 
      default the branch label key the same as the column name, but you may 
      customise this via the COLUMN=NAME syntax.
    default: []
    inputBinding:
      position: 101
      prefix: --branch-labels
  - id: columns
    type:
      type: array
      items: string
    doc: metadata fields to perform discrete reconstruction on
    default: None
    inputBinding:
      position: 101
      prefix: --columns
  - id: confidence
    type:
      - 'null'
      - boolean
    doc: record the distribution of subleading mugration states
    default: false
    inputBinding:
      position: 101
      prefix: --confidence
  - id: metadata
    type: File
    doc: table with metadata
    default: None
    inputBinding:
      position: 101
      prefix: --metadata
  - id: metadata_delimiters
    type:
      - 'null'
      - type: array
        items: string
    doc: delimiters to accept when reading a metadata file. Only one delimiter 
      will be inferred.
    default:
      - ','
      - "\t"
    inputBinding:
      position: 101
      prefix: --metadata-delimiters
  - id: metadata_id_columns
    type:
      - 'null'
      - type: array
        items: string
    doc: names of possible metadata columns containing identifier information, 
      ordered by priority. Only one ID column will be inferred.
    default:
      - strain
      - name
    inputBinding:
      position: 101
      prefix: --metadata-id-columns
  - id: sampling_bias_correction
    type:
      - 'null'
      - float
    doc: a rough estimate of how many more events would have been observed if 
      sequences represented an even sample. This should be roughly the (1-sum_i 
      p_i^2)/(1-sum_i t_i^2), where p_i are the equilibrium frequencies and t_i 
      are apparent ones.(or rather the time spent in a particular state on the 
      tree)
    default: None
    inputBinding:
      position: 101
      prefix: --sampling-bias-correction
  - id: tree
    type: File
    doc: tree to perform trait reconstruction on
    default: None
    inputBinding:
      position: 101
      prefix: --tree
  - id: weights
    type:
      - 'null'
      - File
    doc: tsv/csv table with equilibrium probabilities of discrete states
    default: None
    inputBinding:
      position: 101
      prefix: --weights
outputs:
  - id: output_node_data
    type:
      - 'null'
      - File
    doc: name of JSON file to save trait inferences to
    outputBinding:
      glob: $(inputs.output_node_data)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
