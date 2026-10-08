cwlVersion: v1.2
class: CommandLineTool
baseCommand: feature_merge
label: feature_merge
doc: "Accepts GFF or GTF format.\n\nTool homepage: https://github.com/brinkmanlab/feature_merge"
inputs:
  - id: input1
    type: File
    doc: Input file
    inputBinding:
      position: 201
  - id: input_n
    type:
      - 'null'
      - type: array
        items: File
    doc: Additional input files
    inputBinding:
      position: 202
  - id: exclude_components
    type:
      - 'null'
      - boolean
    doc: Exclude component features from output
    inputBinding:
      position: 103
      prefix: -e
  - id: feature_types
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -f
    doc: Merge groups. Each item is a comma separated list of feature types (terms
      or accessions from the SOFA sequence ontology, "ALL", or "NONE") and gets its
      own -f flag.
    inputBinding:
      position: 103
  - id: identical_coordinates
    type:
      - 'null'
      - boolean
    doc: Only merge features with identical coordinates
    inputBinding:
      position: 103
      prefix: -x
  - id: ignore_sequence_id
    type:
      - 'null'
      - boolean
    doc: Ignore sequence id, merge feature regardless of sequence id
    inputBinding:
      position: 103
      prefix: -s
  - id: ignore_strand
    type:
      - 'null'
      - boolean
    doc: Ignore strand, merge feature regardless of strand
    inputBinding:
      position: 103
      prefix: -i
  - id: merge_strategy
    type:
      - 'null'
      - string
    doc: "Merge strategy used to deal with id collisions between input files.\n  \
      \  merge: attributes of all features with the same primary key will be merged\n\
      \    append: entry will have a unique, autoincremented primary key assigned
      to it (default)\n    error: exception will be raised. This means you will have
      to edit the file yourself to fix the duplicated IDs\n    skip: ignore duplicates,
      emitting a warning\n    replace: keep last duplicate"
    inputBinding:
      position: 103
      prefix: -m
  - id: threshold_distance
    type:
      - 'null'
      - int
    doc: Threshold distance between features to merge
    inputBinding:
      position: 103
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/feature_merge:1.3.0--pyh3252c3a_0
stdout: feature_merge.out
