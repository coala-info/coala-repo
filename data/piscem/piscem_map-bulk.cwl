cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - piscem
  - map-bulk
label: piscem_map-bulk
doc: "map reads for bulk processing\n\nTool homepage: https://github.com/COMBINE-lab/piscem"
inputs:
  - id: ignore_ambig_hits
    type:
      - 'null'
      - boolean
    doc: skip checking of the equivalence classes of k-mers that were too ambiguous
      to be otherwise considered (passing this flag can speed up mapping slightly,
      but may reduce specificity)
    inputBinding:
      position: 101
      prefix: --ignore-ambig-hits
  - id: index
    type: string
    doc: input index prefix
    inputBinding:
      position: 101
      prefix: --index
  - id: max_ec_card
    type:
      - 'null'
      - int
    doc: determines the maximum cardinality equivalence class (number of (txp, orientation
      status) pairs) to examine (cannot be used with --ignore-ambig-hits)
    default: 4096
    inputBinding:
      position: 101
      prefix: --max-ec-card
  - id: max_hit_occ
    type:
      - 'null'
      - int
    doc: in the first pass, consider only k-mers having <= --max-hit-occ hits
    default: 256
    inputBinding:
      position: 101
      prefix: --max-hit-occ
  - id: max_hit_occ_recover
    type:
      - 'null'
      - int
    doc: if all k-mers have > --max-hit-occ hits, then make a second pass and consider
      k-mers having <= --max-hit-occ-recover hits
    default: 1024
    inputBinding:
      position: 101
      prefix: --max-hit-occ-recover
  - id: max_read_occ
    type:
      - 'null'
      - int
    doc: reads with more than this number of mappings will not have their mappings
      reported
    default: 2500
    inputBinding:
      position: 101
      prefix: --max-read-occ
  - id: no_poison
    type:
      - 'null'
      - boolean
    doc: do not consider poison k-mers, even if the underlying index contains them.
      In this case, the mapping results will be identical to those obtained as if
      no poison table was added to the index
    inputBinding:
      position: 101
      prefix: --no-poison
  - id: read1
    type:
      - 'null'
      - type: array
        items: File
    doc: path to a comma-separated list of read 1 files
    inputBinding:
      position: 101
      prefix: --read1
  - id: read2
    type:
      - 'null'
      - type: array
        items: File
    doc: path to a ',' separated list of read 2 files
    inputBinding:
      position: 101
      prefix: --read2
  - id: reads
    type:
      - 'null'
      - type: array
        items: File
    doc: path to a ',' separated list of read unpaired read files
    inputBinding:
      position: 101
      prefix: --reads
  - id: skipping_strategy
    type:
      - 'null'
      - string
    doc: 'skipping strategy to use for k-mer collection [possible values: permissive,
      strict]'
    default: permissive
    inputBinding:
      position: 101
      prefix: --skipping-strategy
  - id: struct_constraints
    type:
      - 'null'
      - boolean
    doc: apply structural constraints when performing mapping
    inputBinding:
      position: 101
      prefix: --struct-constraints
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    default: 16
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type: Directory
    doc: path to output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/piscem:0.14.5--he431ac4_0
