cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gia
  - intersect
label: gia_intersect
doc: "Intersects two BED files\n\nTool homepage: https://github.com/noamteyssier/gia"
inputs:
  - id: compression_level
    type:
      - 'null'
      - int
    doc: "Compression level to use for output files if applicable\n          \n  \
      \        [default: 6]"
    default: 6
    inputBinding:
      position: 101
      prefix: --compression-level
  - id: compression_threads
    type:
      - 'null'
      - int
    doc: "Compression threads to use for output files if applicable\n          \n\
      \          [default: 1]"
    default: 1
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
  - id: inverse
    type:
      - 'null'
      - boolean
    doc: Only report the intervals in the query that do not overlap with the 
      target (i.e. the inverse of the intersection)
    inputBinding:
      position: 101
      prefix: --inverse
  - id: primary_bed_file
    type:
      - 'null'
      - File
    doc: Primary BED file to use
    default: stdin
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
    default: i
    inputBinding:
      position: 101
      prefix: --strandedness
  - id: stream
    type:
      - 'null'
      - boolean
    doc: Stream the input files instead of loading them into memory (only works 
      if both files are sorted)
    inputBinding:
      position: 101
      prefix: --stream
  - id: unique
    type:
      - 'null'
      - boolean
    doc: Only write the query record once if it overlaps with multiple target 
      records
    inputBinding:
      position: 101
      prefix: --unique
  - id: with_query
    type:
      - 'null'
      - boolean
    doc: Return the records from a that overlap with b instead of the 
      intersection
    inputBinding:
      position: 101
      prefix: --with-query
  - id: with_target
    type:
      - 'null'
      - boolean
    doc: Return the records from b that overlap with a instead of the 
      intersection
    inputBinding:
      position: 101
      prefix: --with-target
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
