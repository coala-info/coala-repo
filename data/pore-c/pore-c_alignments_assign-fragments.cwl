cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pore_c, alignments, assign-fragments]
label: pore-c_alignments_assign-fragments
doc: "For each alignment in the alignment table either filter it out or assign a fragment from the fragments table.\n\nTool homepage: https://github.com/nanoporetech/pore-c"
inputs:
  - id: mapping_quality_cutoff
    type:
      - 'null'
      - int
    doc: "Minimum mapping quality for an alignment to be considered. Default: 1"
    inputBinding:
      position: 1
      prefix: --mapping_quality_cutoff
  - id: min_overlap_length
    type:
      - 'null'
      - int
    doc: "Minimum overlap in base pairs between an alignment and restriction fragment. Default: 10"
    inputBinding:
      position: 1
      prefix: --min_overlap_length
  - id: containment_cutoff
    type:
      - 'null'
      - float
    doc: "Minimum percentage of a fragment included in an overlap for that fragment to be considered contained within an alignment. Default: 99.0"
    inputBinding:
      position: 1
      prefix: --containment_cutoff
  - id: align_table
    type: File
    doc: "Alignment table (parquet)"
    inputBinding:
      position: 10
  - id: fragments_table
    type: File
    doc: "Fragments table (*.fragments.parquet)"
    inputBinding:
      position: 11
  - id: pore_c_table
    type: string
    doc: "Output pore-C table (parquet)"
    inputBinding:
      position: 12
outputs:
  - id: pore_c_table_file
    type: File
    doc: "Pore-C alignment table (parquet)"
    outputBinding:
      glob: "$(inputs.pore_c_table)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pore-c:0.4.0--pyhdfd78af_0
