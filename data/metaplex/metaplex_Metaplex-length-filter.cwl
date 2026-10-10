cwlVersion: v1.2
class: CommandLineTool
baseCommand: Metaplex-length-filter
label: metaplex_Metaplex-length-filter
doc: "Removes sequences shorter than a length threshold from a QIIME2 feature table and its representative sequences.\n\nTool homepage: https://github.com/NGabry/MetaPlex"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: feature_table
    type: File
    doc: "Path to the QIIME2 qza file of type FeatureTable[Frequency]."
    inputBinding:
      position: 1
  - id: representative_sequences
    type: File
    doc: "Path to the QIIME2 qza file of type FeatureData[Sequence]."
    inputBinding:
      position: 2
  - id: length_to_filter
    type: int
    doc: "Integer threshold for sequence length. Sequences shorter than this are removed."
    inputBinding:
      position: 3
outputs:
  - id: filtered_table
    type: File
    doc: "Filtered feature table"
    outputBinding:
      glob: "length_filt_table_$(inputs.length_to_filter).qza"
  - id: filtered_seqs
    type: File
    doc: "Filtered representative sequences"
    outputBinding:
      glob: "length_filt_seqs_$(inputs.length_to_filter).qza"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaplex:1.1.0--pyh5e36f6f_0
