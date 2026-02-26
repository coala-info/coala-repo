cwlVersion: v1.2
class: CommandLineTool
baseCommand: lassensus consensus
label: lassensus_consensus
doc: "Consensus calling pipeline\n\nTool homepage: https://github.com/DaanJansen94/lassensus"
inputs:
  - id: input_dir
    type: Directory
    doc: Directory containing input FASTQ files
    inputBinding:
      position: 101
      prefix: --input_dir
  - id: majority_threshold
    type:
      - 'null'
      - float
    doc: Majority rule threshold
    default: 0.7
    inputBinding:
      position: 101
      prefix: --majority_threshold
  - id: max_reads
    type:
      - 'null'
      - int
    doc: Maximum number of reads to use for consensus generation
    default: 1000000
    inputBinding:
      position: 101
      prefix: --max_reads
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Minimum depth for consensus calling
    default: 50
    inputBinding:
      position: 101
      prefix: --min_depth
  - id: min_quality
    type:
      - 'null'
      - int
    doc: Minimum quality score for consensus calling
    default: 30
    inputBinding:
      position: 101
      prefix: --min_quality
outputs:
  - id: output_dir
    type: Directory
    doc: Directory for pipeline output
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lassensus:0.0.5--pyhdfd78af_0
