cwlVersion: v1.2
class: CommandLineTool
baseCommand: gia_window
label: gia_window
doc: "Finds all the overlapping intervals in Set B after adding a window around all
  intervals in Set A\n\nTool homepage: https://github.com/noamteyssier/gia"
inputs:
  - id: a
    type:
      - 'null'
      - File
    doc: Primary BED file to use (default=stdin)
    inputBinding:
      position: 101
      prefix: --a
  - id: b
    type:
      - 'null'
      - type: array
        items: File
    doc: "Secondary BED file(s) to use\n\n          Multiple BED files can be provided,
      mixed format input will be demoted to the lowest rank BED provided."
    inputBinding:
      position: 101
      prefix: --b
  - id: both
    type:
      - 'null'
      - float
    doc: Amount to apply to function on both sides of intervals
    inputBinding:
      position: 101
      prefix: --both
  - id: compression_level
    type:
      - 'null'
      - int
    doc: "Compression level to use for output files if applicable\n\n          [default:
      6]"
    default: 6
    inputBinding:
      position: 101
      prefix: --compression-level
  - id: compression_threads
    type:
      - 'null'
      - int
    doc: "Compression threads to use for output files if applicable\n\n          [default:
      1]"
    default: 1
    inputBinding:
      position: 101
      prefix: --compression-threads
  - id: genome
    type:
      - 'null'
      - File
    doc: Genome file to validate growth against
    inputBinding:
      position: 101
      prefix: --genome
  - id: inverse
    type:
      - 'null'
      - boolean
    doc: Only report the intervals in the query that do not overlap with the 
      target (i.e. the inverse of the intersection)
    inputBinding:
      position: 101
      prefix: --inverse
  - id: left
    type:
      - 'null'
      - float
    doc: Amount to apply to function on the left side of intervals
    inputBinding:
      position: 101
      prefix: --left
  - id: percent
    type:
      - 'null'
      - boolean
    doc: Convert values provided to percentages of the interval length
    inputBinding:
      position: 101
      prefix: --percent
  - id: right
    type:
      - 'null'
      - float
    doc: Amount to apply to function on the right side of intervals
    inputBinding:
      position: 101
      prefix: --right
  - id: stranded
    type:
      - 'null'
      - boolean
    doc: "Follow strand specificity when applying growth\n\n          i.e. if the
      strand is negative, apply growth to the right side of the interval when the
      left side is requested (and vice versa) [default = false]"
    inputBinding:
      position: 101
      prefix: --stranded
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output BED file to write to (default=stdout)
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gia:0.2.23--h588a25a_0
