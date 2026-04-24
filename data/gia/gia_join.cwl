cwlVersion: v1.2
class: CommandLineTool
baseCommand: gia join
label: gia_join
doc: "Joins two BED files\n\nTool homepage: https://github.com/noamteyssier/gia"
inputs:
  - id: compression_level
    type:
      - 'null'
      - int
    doc: "Compression level to use for output files if applicable\n          \n  \
      \        [default: 6]"
    inputBinding:
      position: 101
      prefix: --compression-level
  - id: compression_threads
    type:
      - 'null'
      - int
    doc: "Compression threads to use for output files if applicable\n          \n\
      \          [default: 1]"
    inputBinding:
      position: 101
      prefix: --compression-threads
  - id: either
    type:
      - 'null'
      - boolean
    doc: Requires that either fraction provided with `-f` or `-F` is met
    inputBinding:
      position: 101
      prefix: --either
  - id: fraction_query
    type:
      - 'null'
      - float
    doc: Minimum fraction of a's interval that must be covered by b's interval
    inputBinding:
      position: 101
      prefix: --fraction-query
  - id: fraction_target
    type:
      - 'null'
      - float
    doc: Minimum fraction of b's interval that must be covered by a's interval
    inputBinding:
      position: 101
      prefix: --fraction-target
  - id: how
    type:
      - 'null'
      - string
    doc: "Possible values:\n          - left:  Return all records in the left input
      even if no match is found in right\n          - right: Return all records in
      the right input even if no match is found in left\n          - inner: Return
      only records that have a match in both inputs"
    inputBinding:
      position: 101
      prefix: --how
  - id: primary_bed_file
    type:
      - 'null'
      - File
    doc: Primary BED file to use
    inputBinding:
      position: 101
      prefix: --a
  - id: reciprocal
    type:
      - 'null'
      - boolean
    doc: Require that the fraction provided with `-f` is reciprocal to both 
      query and target
    inputBinding:
      position: 101
      prefix: --reciprocal
  - id: secondary_bed_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Secondary BED file(s) to use\n          \n          Multiple BED files can
      be provided, mixed format input will be demoted to the lowest rank BED provided."
    inputBinding:
      position: 101
      prefix: --b
  - id: sorted
    type:
      - 'null'
      - boolean
    doc: Assert the inputs are pre-sorted
    inputBinding:
      position: 101
      prefix: --sorted
  - id: strandedness
    type:
      - 'null'
      - string
    doc: "Strand-specificity to use when comparing intervals\n          \n       \
      \   i: Ignore strand (default)\n          \n          m: Match strand (+/+ or
      -/- only)\n          \n          o: Opposite strand (+/- or -/+ only)\n    \
      \      \n          [default: i]\n          [possible values: i, m, o]"
    inputBinding:
      position: 101
      prefix: --strandedness
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output BED file to write to
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gia:0.2.23--h588a25a_0
