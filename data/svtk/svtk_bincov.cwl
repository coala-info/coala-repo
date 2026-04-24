cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svtk
  - bincov
label: svtk_bincov
doc: "Calculates non-duplicate primary-aligned binned coverage of a chromosome from\n\
  an input BAM file\n\nTool homepage: https://github.com/talkowski-lab/svtk"
inputs:
  - id: bam
    type: File
    doc: Input bam
    inputBinding:
      position: 1
  - id: chr
    type: string
    doc: Contig to evaluate
    inputBinding:
      position: 2
  - id: binsize
    type:
      - 'null'
      - int
    doc: Bin size (bp)
    inputBinding:
      position: 103
      prefix: --binsize
  - id: blacklist
    type:
      - 'null'
      - File
    doc: BED file of regions to exclude
    inputBinding:
      position: 103
      prefix: --blacklist
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: Compress output bed files
    inputBinding:
      position: 103
      prefix: --gzip
  - id: mode
    type:
      - 'null'
      - string
    doc: Type of coverage to calculate
    inputBinding:
      position: 103
      prefix: --mode
  - id: oldbt
    type:
      - 'null'
      - boolean
    doc: Using a bedtools version pre-2.24.0
    inputBinding:
      position: 103
      prefix: --oldBT
  - id: overlap
    type:
      - 'null'
      - float
    doc: "Maximum fraction of each bin permitted to overlap with\n               \
      \         blacklist regions."
    inputBinding:
      position: 103
      prefix: --overlap
  - id: presubsetted
    type:
      - 'null'
      - boolean
    doc: Input bam is already subsetted to desired chr
    inputBinding:
      position: 103
      prefix: --presubsetted
outputs:
  - id: cov_out
    type: File
    doc: Output bed file of raw coverage
    outputBinding:
      glob: '*.out'
  - id: norm_out
    type:
      - 'null'
      - File
    doc: Output bed file of normalized coverage
    outputBinding:
      glob: $(inputs.norm_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtk:0.0.20190615--py39hbcbf7aa_7
