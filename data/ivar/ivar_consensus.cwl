cwlVersion: v1.2
class: CommandLineTool
baseCommand: ivar_consensus
label: ivar_consensus
doc: "Generates a consensus sequence from pileup data.\n\nTool homepage: https://andersen-lab.github.io/ivar/html/"
inputs:
  - id: fasta_header_name
    type:
      - 'null'
      - string
    doc: Name of fasta header. By default, the prefix is used to create the 
      fasta header in the following format, 
      Consensus_<prefix>_threshold_<frequency-threshold>_quality_<minimum-quality>_<min-insert-threshold>
    inputBinding:
      position: 101
      prefix: -i
  - id: low_depth_char
    type:
      - 'null'
      - string
    doc: (N/-) Character to print in regions with less than minimum coverage
    default: N
    inputBinding:
      position: 101
      prefix: -n
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Minimum depth to call consensus
    default: 10
    inputBinding:
      position: 101
      prefix: -m
  - id: min_frequency_threshold
    type:
      - 'null'
      - float
    doc: Minimum frequency threshold(0 - 1) to call consensus.
    default: 0
    inputBinding:
      position: 101
      prefix: -t
  - id: min_insertion_frequency_threshold
    type:
      - 'null'
      - float
    doc: Minimum insertion frequency threshold(0 - 1) to call consensus.
    default: 0.8
    inputBinding:
      position: 101
      prefix: -c
  - id: min_quality_score
    type:
      - 'null'
      - int
    doc: Minimum quality score threshold to count base
    default: 20
    inputBinding:
      position: 101
      prefix: -q
  - id: output_prefix
    type: string
    doc: Prefix for the output fasta file and quality file
    inputBinding:
      position: 101
      prefix: -p
  - id: skip_low_depth_regions
    type:
      - 'null'
      - boolean
    doc: If '-k' flag is added, regions with depth less than minimum depth will 
      not be added to the consensus sequence. Using '-k' will override any 
      option specified using -n
    inputBinding:
      position: 101
      prefix: -k
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ivar:1.4.4--h077b44d_0
stdout: ivar_consensus.out
