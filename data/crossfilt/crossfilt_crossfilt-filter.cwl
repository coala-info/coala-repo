cwlVersion: v1.2
class: CommandLineTool
baseCommand: crossfilt-filter
label: crossfilt_crossfilt-filter
doc: "Outputs reads from bam1 that that have identical contig, position, CIGAR string,
  and tag values (optional) in bam2\n\nTool homepage: https://github.com/kennethabarr/CrossFilt"
inputs:
  - id: bam1
    type: File
    doc: Input bam file 1.
    inputBinding:
      position: 1
  - id: bam2
    type: File
    doc: Input bam file 2.
    inputBinding:
      position: 2
  - id: compare_xf_tag
    type:
      - 'null'
      - boolean
    doc: Compare the XF tag. Equivalent to --tag XF
    inputBinding:
      position: 103
      prefix: --xf
  - id: tags
    type:
      - 'null'
      - type: array
        items: string
    doc: Tag values to compare. Can be specified multiple times to compare 
      multiple tags.
    inputBinding:
      position: 103
      prefix: --tag
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of compression/decrpression threads when reading/writing bam 
      files.
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crossfilt:0.2.1--pyhdfd78af_0
stdout: crossfilt_crossfilt-filter.out
