cwlVersion: v1.2
class: CommandLineTool
baseCommand: bam2consensus
label: b2b-utils_bam2consensus
doc: "Re-calls a consensus sequence based on a BAM alignment to reference, with various
  knobs and optional output formats\n\nTool homepage: https://github.com/jvolkening/b2b-utils"
inputs:
  - id: bam_file
    type: File
    doc: Path to input BAM alignments
    inputBinding:
      position: 101
      prefix: --bam
  - id: bg_bin_figs
    type:
      - 'null'
      - int
    doc: If greater than zero, the number of significant figures used to bin 
      depths in bedgraph output. If zero, no binning is applied. This option is 
      useful to reduce the size of bedgraph output by binning similar depth 
      values when high resolution is not important.
    default: 0
    inputBinding:
      position: 101
      prefix: --bg_bin_figs
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Minimum read depth for consensus to be called (otherwise called as 
      "N").
    default: 3
    inputBinding:
      position: 101
      prefix: --min_depth
  - id: min_qual
    type:
      - 'null'
      - int
    doc: Minimum quality for a base to be considered in consensus calling.
    default: 10
    inputBinding:
      position: 101
      prefix: --min_qual
  - id: ref_file
    type: File
    doc: Path to reference sequence used to generate BAM alignments
    inputBinding:
      position: 101
      prefix: --ref
  - id: trim
    type:
      - 'null'
      - float
    doc: Fraction to trim from each end when calculating trimmed mean of error 
      window.
    default: 0.2
    inputBinding:
      position: 101
      prefix: --trim
  - id: window
    type:
      - 'null'
      - int
    doc: Size of sliding window used to calculate local error rates.
    default: 30
    inputBinding:
      position: 101
      prefix: --window
outputs:
  - id: consensus_file
    type: File
    doc: Path to write consensus sequence to (as FASTA)
    outputBinding:
      glob: $(inputs.consensus_file)
  - id: bedgraph_file
    type:
      - 'null'
      - File
    doc: Path to write coverage file to (as bedgraph)
    outputBinding:
      glob: $(inputs.bedgraph_file)
  - id: table_file
    type:
      - 'null'
      - File
    doc: Path to write coverage file to (as tab-separated table)
    outputBinding:
      glob: $(inputs.table_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/b2b-utils:0.020--pl5321h9ee0642_0
