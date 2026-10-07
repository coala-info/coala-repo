cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chamois
  - explain
label: chamois_explain_cluster
doc: "Explain which genes of a cluster contribute to which predicted classes.\n\nTool homepage: https://chamois.readthedocs.io/"
arguments:
  - position: 2
    valueFrom: cluster
inputs:
  - id: model
    type:
      - 'null'
      - File
    doc: The path to an alternative model to extract weights from (default is 
      the model shipped with CHAMOIS). This is an option of 'chamois explain'.
    inputBinding:
      position: 1
      prefix: --model
  - id: input
    type: File
    doc: The input BGC sequences to process (GenBank).
    inputBinding:
      position: 3
      prefix: --input
  - id: hmm
    type:
      - 'null'
      - File
    doc: The path to the HMM file containing protein domains for annotation.
    inputBinding:
      position: 3
      prefix: --hmm
  - id: disentangle
    type:
      - 'null'
      - boolean
    doc: Remove overlapping domains by best P-value.
    inputBinding:
      position: 3
      prefix: --disentangle
  - id: cds
    type:
      - 'null'
      - boolean
    doc: Use CDS features in the GenBank input as genes instead of running 
      Pyrodigal.
    inputBinding:
      position: 3
      prefix: --cds
  - id: output
    type:
      - 'null'
      - string
    doc: The path where to write the contribution table in TSV format.
    inputBinding:
      position: 3
      prefix: --output
  - id: render
    type:
      - 'null'
      - boolean
    doc: Display the contribution table in the console.
    inputBinding:
      position: 3
      prefix: --render
  - id: cluster_id
    type:
      - 'null'
      - string
    doc: 'The cluster to explain (default: all clusters in the input)'
    inputBinding:
      position: 4
outputs:
  - id: stdout
    type: stdout
    doc: Console output (the table when render is set)
  - id: output_table
    type:
      - 'null'
      - File
    doc: Contribution table in TSV format
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chamois:0.2.2--pyhdfd78af_0
stdout: chamois_explain_cluster.out
