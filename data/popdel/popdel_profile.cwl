cwlVersion: v1.2
class: CommandLineTool
baseCommand: PopDel
label: popdel_profile
doc: "Profile creation from BAM/CRAM file\n\nTool homepage: https://github.com/kehrlab/PopDel"
inputs:
  - id: input_bam_cram_file
    type: File
    doc: BAM/CRAM-FILE
    inputBinding:
      position: 1
  - id: regions
    type:
      - 'null'
      - type: array
        items: string
    doc: CHROM:BEGIN-END [CHROM:BEGIN-END ...]
    inputBinding:
      position: 2
  - id: full_help
    type:
      - 'null'
      - boolean
    doc: Displays full list of options.
    inputBinding:
      position: 103
      prefix: --fullHelp
  - id: intervals
    type:
      - 'null'
      - File
    doc: File with genomic intervals for parameter estimation instead of default
      intervals (see README). One closed interval per line, formatted as 
      'CHROM:START-END', 1-based coordinates.
    inputBinding:
      position: 103
      prefix: --intervals
  - id: max_deletion_size
    type:
      - 'null'
      - int
    doc: Maximum size of deletions.
    inputBinding:
      position: 103
      prefix: --max-deletion-size
  - id: merge_read_groups
    type:
      - 'null'
      - boolean
    doc: Merge all read groups of the sample. Only advised if they share the 
      same properties!
    inputBinding:
      position: 103
      prefix: --merge-read-groups
  - id: min_read_num
    type:
      - 'null'
      - int
    doc: Minimum number of read pairs for parameter estimation (per read group)
    inputBinding:
      position: 103
      prefix: --min-read-num
  - id: reference
    type:
      - 'null'
      - string
    doc: Reference genome version used for the mapping. Not used when using 
      custom sampling intervals (option '-i'). One of 'GRCh37', 'GRCh38', 
      'hg19', 'hg38' (case-insensitive).
    inputBinding:
      position: 103
      prefix: --reference
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Output file name.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popdel:1.5.0--h6b13edd_1
