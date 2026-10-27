cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vt
  - partition
label: vt_partition
doc: "partition variants from two data sets.\n\nTool homepage: https://github.com/atks/vt"
inputs:
  - id: input_vcfs
    type:
      type: array
      items: File
    doc: Input VCF files
    inputBinding:
      position: 1
  - id: filter
    type:
      - 'null'
      - string
    doc: filter
    inputBinding:
      position: 102
      prefix: -f
  - id: interval_list_file
    type:
      - 'null'
      - File
    doc: file containing list of intervals
    inputBinding:
      position: 102
      prefix: -I
  - id: intervals
    type:
      - 'null'
      - string
    doc: intervals
    inputBinding:
      position: 102
      prefix: -i
  - id: write_partitioned_variants_to_file
    type:
      - 'null'
      - boolean
    doc: write partitioned variants to file
    inputBinding:
      position: 102
      prefix: -w
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: summary
    type: stderr
    doc: Partition summary (vt writes it to standard error)
  - id: partitioned_variants
    type:
      - 'null'
      - type: array
        items: File
    doc: Partitioned variants (a-b.bcf, a&b1.bcf, a&b2.bcf, b-a.bcf), written with -w
    outputBinding:
      glob: '*.bcf'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vt:2015.11.10--2
stdout: vt_partition.out
stderr: vt_partition.err
