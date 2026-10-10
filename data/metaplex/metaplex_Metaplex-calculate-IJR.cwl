cwlVersion: v1.2
class: CommandLineTool
baseCommand: Metaplex-calculate-IJR
label: metaplex_Metaplex-calculate-IJR
doc: "Calculates the index jump rate from calibrator tag pairs of demultiplexed QIIME2 reads.\n\nTool homepage: https://github.com/NGabry/MetaPlex"
inputs:
  - id: demultiplexed_seqs
    type: File
    doc: "Path to the demultiplexed QIIME2 qza file of type SampleData[SequencesWithQuality]."
    inputBinding:
      position: 1
  - id: sample_map
    type: File
    doc: "Path to the tab delimited QIIME2 sample map file."
    inputBinding:
      position: 2
  - id: calibrator_tag_pairs
    type:
      - 'null'
      - type: array
        items: string
    doc: "Pairs of calibrator tags, each as two zero padded digits separated by a comma, for example 01,11."
    inputBinding:
      position: 3
outputs:
  - id: expected_false_reads
    type: File
    doc: "Expected number of false reads in each sample"
    outputBinding:
      glob: "Expected_False_Reads_Per_Index.csv"
  - id: log
    type: File
    doc: "Summary statistics"
    outputBinding:
      glob: "log.txt"
  - id: tsvs
    type:
      - 'null'
      - Directory
    doc: "Summary tables extracted from the QIIME2 visualisation"
    outputBinding:
      glob: "tsvs"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaplex:1.1.0--pyh5e36f6f_0
