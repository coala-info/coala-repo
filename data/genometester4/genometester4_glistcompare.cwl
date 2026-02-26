cwlVersion: v1.2
class: CommandLineTool
baseCommand: glistcompare
label: genometester4_glistcompare
doc: "Compares lists of k-mers.\n\nTool homepage: https://github.com/bioinfo-ut/GenomeTester4"
inputs:
  - id: input_list1
    type: File
    doc: First input list of k-mers
    inputBinding:
      position: 1
  - id: input_list2
    type:
      - 'null'
      - type: array
        items: File
    doc: Additional input lists of k-mers
    inputBinding:
      position: 2
  - id: method
    type: string
    doc: Comparison method (union, intersection, difference, double_difference, 
      diff_union)
    inputBinding:
      position: 3
  - id: count_only
    type:
      - 'null'
      - boolean
    doc: output count of k-mers instead of k-mers themself
    inputBinding:
      position: 104
      prefix: --count_only
  - id: cutoff
    type:
      - 'null'
      - int
    doc: specify frequency cut-off (default 1)
    default: 1
    inputBinding:
      position: 104
      prefix: --cutoff
  - id: debug_level
    type:
      - 'null'
      - boolean
    doc: increase debug level
    inputBinding:
      position: 104
      prefix: -D
  - id: diff_union
    type:
      - 'null'
      - boolean
    doc: subtract first list from the second and finds difference
    inputBinding:
      position: 104
      prefix: --diff_union
  - id: difference
    type:
      - 'null'
      - boolean
    doc: difference of input lists
    inputBinding:
      position: 104
      prefix: --difference
  - id: disable_scouts
    type:
      - 'null'
      - boolean
    doc: disable list read-ahead in background thread
    inputBinding:
      position: 104
      prefix: --disable_scouts
  - id: double_difference
    type:
      - 'null'
      - boolean
    doc: double difference of input lists
    inputBinding:
      position: 104
      prefix: --double_difference
  - id: intersection
    type:
      - 'null'
      - boolean
    doc: intersection of input lists
    inputBinding:
      position: 104
      prefix: --intersection
  - id: mismatches
    type:
      - 'null'
      - int
    doc: specify number of mismatches (default 0, can be used with -diff and 
      -ddiff)
    default: 0
    inputBinding:
      position: 104
      prefix: --mismatch
  - id: output_name
    type:
      - 'null'
      - string
    doc: specify output name (default "out")
    default: out
    inputBinding:
      position: 104
      prefix: --outputname
  - id: rule
    type:
      - 'null'
      - string
    doc: "specify rule how final frequencies are calculated (default, add, subtract,
      min, max, first, second, 1, 2)\nNOTE: rules min, subtract, first and second
      can only be used with finding the intersection."
    default: default
    inputBinding:
      position: 104
      prefix: --rule
  - id: subset_method
    type:
      - 'null'
      - string
    doc: make subset with given method (rand, rand_unique)
    inputBinding:
      position: 104
      prefix: --subset
  - id: subset_size
    type:
      - 'null'
      - int
    doc: make subset with given size
    inputBinding:
      position: 104
      prefix: --subset
  - id: union
    type:
      - 'null'
      - boolean
    doc: union of input lists
    inputBinding:
      position: 104
      prefix: --union
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genometester4:4.0--hec16e2b_4
stdout: genometester4_glistcompare.out
