cwlVersion: v1.2
class: CommandLineTool
baseCommand: lassensus
label: lassensus_consensus
doc: "Consensus calling pipeline\n\nTool homepage: https://github.com/DaanJansen94/lassensus"
inputs:
  - id: input_dir
    type: Directory
    doc: Directory containing input FASTQ files
    inputBinding:
      position: 1
      prefix: --input_dir
  - id: reference_selection_dir
    type: Directory
    doc: Output directory of lassensus reference-selection (holds the consensus/ sample folders); it is copied and extended
  - id: majority_threshold
    type:
      - 'null'
      - float
    doc: Majority rule threshold
    inputBinding:
      position: 101
      prefix: --majority_threshold
  - id: max_reads
    type:
      - 'null'
      - int
    doc: Maximum number of reads to use for consensus generation
    inputBinding:
      position: 101
      prefix: --max_reads
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Minimum depth for consensus calling
    inputBinding:
      position: 101
      prefix: --min_depth
  - id: min_quality
    type:
      - 'null'
      - int
    doc: Minimum quality score for consensus calling
    inputBinding:
      position: 101
      prefix: --min_quality
  - id: output_dir_path
    type: string
    doc: Directory for pipeline output
    inputBinding:
      position: 2
      prefix: --output_dir
arguments:
  - position: 3
    valueFrom: consensus
  - position: 4
    prefix: --input_dir
    valueFrom: $(inputs.input_dir.path)
  - position: 5
    prefix: --output_dir
    valueFrom: $(inputs.output_dir_path)
outputs:
  - id: output_dir
    type: Directory
    doc: Directory for pipeline output
    outputBinding:
      glob: $(inputs.output_dir_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.reference_selection_dir)
        entryname: $(inputs.output_dir_path)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lassensus:0.0.5--pyhdfd78af_0
