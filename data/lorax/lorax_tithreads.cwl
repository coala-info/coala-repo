cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lorax
  - tithreads
label: lorax_tithreads
doc: "Tells you the ploidy of a tumor sample based on its BAM file.\n\nTool homepage:
  https://github.com/tobiasrausch/lorax"
inputs:
  - id: tumor_bam
    type: File
    doc: tumor BAM file
    inputBinding:
      position: 1
  - id: control_bam
    type: File
    doc: matched control BAM
    inputBinding:
      position: 102
      prefix: --matched
  - id: genome_fasta
    type: File
    doc: genome fasta file
    inputBinding:
      position: 102
      prefix: --genome
  - id: max_contamination
    type:
      - 'null'
      - float
    doc: max. fractional tumor-in-normal contamination
    inputBinding:
      position: 102
      prefix: --contam
  - id: max_segment_size
    type:
      - 'null'
      - int
    doc: max. segment size
    inputBinding:
      position: 102
      prefix: --maxsize
  - id: min_chromosome_length
    type:
      - 'null'
      - int
    doc: min. chromosome length
    inputBinding:
      position: 102
      prefix: --chrlen
  - id: min_clipping_length
    type:
      - 'null'
      - int
    doc: min. clipping length
    inputBinding:
      position: 102
      prefix: --clip
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: min. mapping quality
    inputBinding:
      position: 102
      prefix: --qual
  - id: min_segment_size
    type:
      - 'null'
      - int
    doc: min. segment size
    inputBinding:
      position: 102
      prefix: --minsize
  - id: min_sequence_entropy
    type:
      - 'null'
      - float
    doc: min. sequence entropy
    inputBinding:
      position: 102
      prefix: --entropy
  - id: min_split_read_support
    type:
      - 'null'
      - int
    doc: min. split-read support
    inputBinding:
      position: 102
      prefix: --split
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: output prefix
    inputBinding:
      position: 102
      prefix: --outprefix
  - id: ploidy
    type:
      - 'null'
      - int
    doc: ploidy
    inputBinding:
      position: 102
      prefix: --ploidy
  - id: sd_coverage_deviation
    type:
      - 'null'
      - int
    doc: SD for coverage deviation
    inputBinding:
      position: 102
      prefix: --sd
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lorax:0.5.1--h4d20210_0
stdout: lorax_tithreads.out
