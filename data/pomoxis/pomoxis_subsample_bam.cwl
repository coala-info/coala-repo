cwlVersion: v1.2
class: CommandLineTool
baseCommand: subsample_bam
label: pomoxis_subsample_bam
doc: "Subsample a bam to uniform or proportional depth\n\nTool homepage: https://github.com/nanoporetech/pomoxis"
inputs:
  - id: bam
    type: File
    doc: input bam file.
    inputBinding:
      position: 1
  - id: depth
    type:
      type: array
      items: int
    doc: Target depth.
    inputBinding:
      position: 2
  - id: accuracy
    type:
      - 'null'
      - float
    doc: Filter reads by accuracy.
    inputBinding:
      position: 103
      prefix: --accuracy
  - id: all_fail
    type:
      - 'null'
      - boolean
    doc: Exit with an error if all regions have insufficient coverage.
    inputBinding:
      position: 103
  - id: any_fail
    type:
      - 'null'
      - boolean
    doc: Exit with an error if any region has insufficient coverage.
    inputBinding:
      position: 103
  - id: coverage
    type:
      - 'null'
      - float
    doc: Filter reads by coverage (what fraction of the read aligns).
    inputBinding:
      position: 103
      prefix: --coverage
  - id: force_low_depth
    type:
      - 'null'
      - boolean
    doc: Force saving reads mapped to a sequence with coverage below the 
      expected value.
    inputBinding:
      position: 103
  - id: keep_supplementary
    type:
      - 'null'
      - boolean
    doc: Include supplementary alignments.
    inputBinding:
      position: 103
  - id: keep_unmapped
    type:
      - 'null'
      - boolean
    doc: Include unmapped reads.
    inputBinding:
      position: 103
  - id: length
    type:
      - 'null'
      - int
    doc: Filter reads by read length.
    inputBinding:
      position: 103
      prefix: --length
  - id: orientation
    type:
      - 'null'
      - string
    doc: Sample only forward or reverse reads.
    inputBinding:
      position: 103
      prefix: --orientation
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output prefix
    inputBinding:
      position: 103
      prefix: --output_prefix
  - id: patience
    type:
      - 'null'
      - int
    doc: Maximum iterations with no change in median coverage before aborting.
    inputBinding:
      position: 103
      prefix: --patience
  - id: primary_only
    type:
      - 'null'
      - boolean
    doc: Use only primary reads.
    inputBinding:
      position: 103
  - id: profile
    type:
      - 'null'
      - int
    doc: Stride in genomic coordinates for depth profile.
    inputBinding:
      position: 103
      prefix: --profile
  - id: proportional
    type:
      - 'null'
      - boolean
    doc: Activate proportional sampling, thus keeping depth variations of the 
      pileup.
    inputBinding:
      position: 103
      prefix: --proportional
  - id: quality
    type:
      - 'null'
      - int
    doc: Filter reads by mean qscore.
    inputBinding:
      position: 103
      prefix: --quality
  - id: regions
    type:
      - 'null'
      - type: array
        items: string
    doc: Only process given regions.
    inputBinding:
      position: 103
      prefix: --regions
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed for proportional downsampling of reads.
    inputBinding:
      position: 103
      prefix: --seed
  - id: stride
    type:
      - 'null'
      - int
    doc: Stride in genomic coordinates when searching for new reads. Smaller can
      lead to more compact pileup.
    inputBinding:
      position: 103
      prefix: --stride
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
stdout: pomoxis_subsample_bam.out
