cwlVersion: v1.2
class: CommandLineTool
baseCommand: debreak.py
label: debreak
doc: "SV caller for long-read sequencing data\n\nTool homepage: https://github.com/ChongLab/DeBreak"
inputs:
  - id: aligner
    type:
      - 'null'
      - string
    doc: aligner used to generate BAM/SAM
    inputBinding:
      position: 101
      prefix: --aligner
  - id: bam
    type: File
    doc: input sorted bam. index required
    inputBinding:
      position: 101
      prefix: --bam
  - id: depth
    type:
      - 'null'
      - int
    doc: sequencing depth of this dataset
    inputBinding:
      position: 101
      prefix: --depth
  - id: max_size
    type:
      - 'null'
      - int
    doc: maxminal size of detected SV
    inputBinding:
      position: 101
      prefix: --max_size
  - id: maxcov
    type:
      - 'null'
      - int
    doc: Maximal coverage for a SV. Suggested maxcov as 2 times mean depth.
    inputBinding:
      position: 101
      prefix: --maxcov
  - id: min_quality
    type:
      - 'null'
      - int
    doc: minimal mapping quality of reads
    inputBinding:
      position: 101
      prefix: --min_quality
  - id: min_size
    type:
      - 'null'
      - int
    doc: minimal size of detected SV
    inputBinding:
      position: 101
      prefix: --min_size
  - id: min_support
    type:
      - 'null'
      - int
    doc: minimal number of supporting reads for one event
    inputBinding:
      position: 101
      prefix: --min_support
  - id: no_genotype
    type:
      - 'null'
      - boolean
    doc: disable genotyping
    inputBinding:
      position: 101
      prefix: --no_genotype
  - id: poa
    type:
      - 'null'
      - boolean
    doc: POA for accurate breakpoint. wtdbg2,minimap2,ref required.
    inputBinding:
      position: 101
      prefix: --poa
  - id: ref
    type:
      - 'null'
      - File
    doc: reference genome. Should be same with SAM/BAM
    inputBinding:
      position: 101
      prefix: --ref
  - id: rescue_dup
    type:
      - 'null'
      - boolean
    doc: rescue DUP from INS calls. minimap2,ref required
    inputBinding:
      position: 101
      prefix: --rescue_dup
  - id: rescue_large_ins
    type:
      - 'null'
      - boolean
    doc: rescue large INS. wtdbg2,minimap2,ref required
    inputBinding:
      position: 101
      prefix: --rescue_large_ins
  - id: samlist
    type:
      - 'null'
      - string
    doc: a list of SAM files of same sample
    inputBinding:
      position: 101
      prefix: --samlist
  - id: skip_detect
    type:
      - 'null'
      - boolean
    doc: Skip SV raw signal detection.
    inputBinding:
      position: 101
      prefix: --skip_detect
  - id: thread
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: --thread
  - id: tumor
    type:
      - 'null'
      - boolean
    doc: Allow clustered SV breakpoints during raw SV signal detection
    inputBinding:
      position: 101
      prefix: --tumor
outputs:
  - id: outpath
    type:
      - 'null'
      - Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.outpath)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/debreak:1.3--h9ee0642_0
