cwlVersion: v1.2
class: CommandLineTool
baseCommand: Metaplex-per-sample-filter
label: metaplex_Metaplex-per-sample-filter
doc: "Filters reads out of a QIIME2 feature table with a minimum read count requirement per sample.\n\nTool homepage: https://github.com/NGabry/MetaPlex"
inputs:
  - id: feature_table
    type: File
    doc: "Path to the QIIME2 feature table (qza or biom)."
    inputBinding:
      position: 1
  - id: filtering_csv
    type:
      - 'null'
      - File
    doc: "Expected_False_Reads_Per_Index.csv written by Metaplex-calculate-IJR (per sample thresholds). Give this or filtering_integer."
    inputBinding:
      position: 2
  - id: filtering_integer
    type:
      - 'null'
      - int
    doc: "Integer for even filtering across samples. Give this or filtering_csv."
    inputBinding:
      position: 2
outputs:
  - id: filtered_table
    type: File
    doc: "Filtered feature table"
    outputBinding:
      glob: "freq_filt_table.qza"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaplex:1.1.0--pyh5e36f6f_0
