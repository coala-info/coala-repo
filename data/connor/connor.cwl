cwlVersion: v1.2
class: CommandLineTool
baseCommand: connor
label: connor
doc: "Deduplicates BAM file based on custom inline DNA barcodes. Emits a new BAM file
  reduced to a single consensus read for each family of original reads.\n\nTool homepage:
  https://github.com/umich-brcf-bioinf/Connor"
inputs:
  - id: input_bam
    type: File
    doc: path to input BAM
    inputBinding:
      position: 1
  - id: consensus_freq_threshold
    type:
      - 'null'
      - float
    doc: Ambiguous base calls at a specific position in a family are transformed
      to either majority base call, or N if the majority percentage is below 
      this threshold. (Higher threshold results in more Ns in consensus.)
    inputBinding:
      position: 102
      prefix: --consensus_freq_threshold
  - id: filter_order
    type:
      - 'null'
      - string
    doc: determines how filters will be ordered in the log results
    inputBinding:
      position: 102
      prefix: --filter_order
  - id: force
    type:
      - 'null'
      - boolean
    doc: Override validation warnings
    inputBinding:
      position: 102
      prefix: --force
  - id: log_file
    type:
      - 'null'
      - File
    doc: Path to verbose log file
    inputBinding:
      position: 102
      prefix: --log_file
  - id: min_family_size_threshold
    type:
      - 'null'
      - int
    doc: families with count of original reads < threshold are excluded from the
      deduplicated output. (Higher threshold is more stringent.)
    inputBinding:
      position: 102
      prefix: --min_family_size_threshold
  - id: umt_distance_threshold
    type:
      - 'null'
      - int
    doc: UMTs equal to or closer than this Hamming distance will be combined 
      into a single family. Lower threshold make more families with more 
      consistent UMTs; 0 implies UMI must match exactly.
    inputBinding:
      position: 102
      prefix: --umt_distance_threshold
  - id: umt_length
    type:
      - 'null'
      - int
    doc: length of UMT
    inputBinding:
      position: 102
      prefix: --umt_length
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print all log messages to console
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_bam
    type: File
    doc: path to deduplicated output BAM
    outputBinding:
      glob: '*.out'
  - id: annotated_output_bam
    type:
      - 'null'
      - File
    doc: path to output BAM containing all original aligns annotated with BAM 
      tags
    outputBinding:
      glob: $(inputs.annotated_output_bam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connor:0.6.1--py_0
