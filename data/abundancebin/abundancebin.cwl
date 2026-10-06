cwlVersion: v1.2
class: CommandLineTool
baseCommand: abundancebin
label: abundancebin
doc: "A tool for binning metagenomic sequences based on abundance and k-mer composition.\n \nTool homepage: https://github.com/movingpictures83/AbundanceBin"
inputs:
  - id: bin_num
    type:
      - 'null'
      - int
    doc: bin number (if known)
    inputBinding:
      position: 101
      prefix: -bin_num
  - id: exclude
    type:
      - 'null'
      - int
    doc: exclude count
    inputBinding:
      position: 101
      prefix: -exclude
  - id: exclude_max
    type:
      - 'null'
      - int
    doc: exclude max count
    inputBinding:
      position: 101
      prefix: -exclude_max
  - id: input_file
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 101
      prefix: -input
  - id: kmer_len
    type:
      - 'null'
      - int
    doc: composition len
    inputBinding:
      position: 101
      prefix: -kmer_len
  - id: output_fasta
    type:
      - 'null'
      - boolean
    doc: Output results in FASTA format
    inputBinding:
      position: 101
      prefix: -OUTPUT_FASTA
  - id: recursive_classification
    type:
      - 'null'
      - boolean
    doc: undergo recursive classification
    inputBinding:
      position: 101
      prefix: -RECURSIVE_CLASSIFICATION
  - id: output_file_path
    type: string
    doc: 'Output log; bins are written beside it as <name>.1, <name>.2, ... (default would be <input>.log next to the read-only input).'
    inputBinding:
      position: 102
      prefix: -output
    default: abundancebin.log
outputs:
  - id: output_file
    type: File
    doc: Run log with EM parameters and class sizes.
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: bins
    type:
      type: array
      items: File
    doc: Classified reads, one file per bin (<name>.1, <name>.2, ...).
    outputBinding:
      glob: $(inputs.output_file_path).[0-9]*
  - id: unclassified
    type: File?
    outputBinding:
      glob: $(inputs.output_file_path).unclassified
  - id: bin_feature
    type: File?
    outputBinding:
      glob: $(inputs.output_file_path).bin_feature
  - id: counts
    type: File?
    outputBinding:
      glob: $(inputs.output_file_path).count
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/abundancebin:1.0.1--h9f5acd7_4
