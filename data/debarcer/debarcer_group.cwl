cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - debarcer.py
  - group
label: debarcer_group
doc: "Group UMIs based on proximity and abundance.\n\nTool homepage: https://github.com/oicr-gsi/debarcer"
inputs:
  - id: bam_file
    type:
      - 'null'
      - File
    doc: Path to the BAM file
    inputBinding:
      position: 101
      prefix: --Bamfile
  - id: config_file
    type:
      - 'null'
      - File
    doc: Path to the config file
    inputBinding:
      position: 101
      prefix: --Config
  - id: distance_threshold
    type:
      - 'null'
      - int
    doc: Hamming distance threshold for connecting parent-children umis
    inputBinding:
      position: 101
      prefix: --Distance
  - id: ignore
    type:
      - 'null'
      - boolean
    doc: Keep the most abundant family and ignore families at other positions 
      within each group. Default is False
    inputBinding:
      position: 101
      prefix: --Ignore
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory where subdirectories are created
    inputBinding:
      position: 101
      prefix: --Outdir
  - id: position_threshold
    type:
      - 'null'
      - int
    doc: Umi position threshold for grouping umis together
    inputBinding:
      position: 101
      prefix: --Position
  - id: read_count
    type:
      - 'null'
      - int
    doc: Minimum number of reads in region required for grouping. Default is 0
    inputBinding:
      position: 101
      prefix: --ReadCount
  - id: region
    type: string
    doc: Region coordinates to search for UMIs. chrN:posA-posB. posA and posB 
      are 1-based included
    inputBinding:
      position: 101
      prefix: --Region
  - id: separator
    type:
      - 'null'
      - string
    doc: String separating the UMI from the remaining of the read name
    inputBinding:
      position: 101
      prefix: --Separator
  - id: truncate
    type:
      - 'null'
      - boolean
    doc: Discard reads overlapping with the genomic region if True. Default is 
      False
    inputBinding:
      position: 101
      prefix: --Truncate
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/debarcer:2.1.4--pyhdfd78af_2
stdout: debarcer_group.out
