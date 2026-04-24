cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - piscem
  - map-sc-atac
label: piscem_map-sc-atac
doc: "map reads for scAtac processing\n\nTool homepage: https://github.com/COMBINE-lab/piscem"
inputs:
  - id: barcode
    type:
      - 'null'
      - type: array
        items: File
    doc: path to a ',' separated list of read 2 files
    inputBinding:
      position: 101
      prefix: --barcode
  - id: bclen
    type:
      - 'null'
      - int
    doc: the length of the barcode sequence
    inputBinding:
      position: 101
      prefix: --bclen
  - id: bed_format
    type:
      - 'null'
      - boolean
    doc: output mappings in bed format
    inputBinding:
      position: 101
      prefix: --bed-format
  - id: bin_overlap
    type:
      - 'null'
      - int
    doc: size for bin overlap, default set to 300
    inputBinding:
      position: 101
      prefix: --bin-overlap
  - id: bin_size
    type:
      - 'null'
      - int
    doc: size of virtual color, default set to 1000
    inputBinding:
      position: 101
      prefix: --bin-size
  - id: check_kmer_orphan
    type:
      - 'null'
      - boolean
    doc: Check if any mapping kmer exist for a mate which is not mapped, but there
      exists mapping for the other read. If set to true and a mapping kmer exists,
      then the pair would not be mapped (default false)
    inputBinding:
      position: 101
      prefix: --check-kmer-orphan
  - id: end_cache_capacity
    type:
      - 'null'
      - int
    doc: the capacity of the cache used to provide fast lookup for k-mers at the ends
      of unitigs
    inputBinding:
      position: 101
      prefix: --end-cache-capacity
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
    type: File
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
    inputBinding:
      position: 101
      prefix: --max-ec-card
  - id: max_hit_occ
    type:
      - 'null'
      - int
    doc: in the first pass, consider only k-mers having <= --max-hit-occ hits
    inputBinding:
      position: 101
      prefix: --max-hit-occ
  - id: max_hit_occ_recover
    type:
      - 'null'
      - int
    doc: if all k-mers have > --max-hit-occ hits, then make a second pass and consider
      k-mers having <= --max-hit-occ-recover hits
    inputBinding:
      position: 101
      prefix: --max-hit-occ-recover
  - id: max_read_occ
    type:
      - 'null'
      - int
    doc: reads with more than this number of mappings will not have their mappings
      reported
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
  - id: no_tn5_shift
    type:
      - 'null'
      - boolean
    doc: do not apply Tn5 shift to mapped positions
    inputBinding:
      position: 101
      prefix: --no-tn5-shift
  - id: read1
    type:
      - 'null'
      - type: array
        items: File
    doc: path to a ',' separated list of read 1 files
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
      - File
    doc: path to reads
    inputBinding:
      position: 101
      prefix: --reads
  - id: sam_format
    type:
      - 'null'
      - boolean
    doc: output mappings in sam format
    inputBinding:
      position: 101
      prefix: --sam-format
  - id: skipping_strategy
    type:
      - 'null'
      - string
    doc: 'the skipping strategy to use for k-mer collection [possible values: permissive,
      strict]'
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
  - id: thr
    type:
      - 'null'
      - float
    doc: threshold to be considered for pseudoalignment, default set to 0.7
    inputBinding:
      position: 101
      prefix: --thr
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: use_chr
    type:
      - 'null'
      - boolean
    doc: use chromosomes as color
    inputBinding:
      position: 101
      prefix: --use-chr
outputs:
  - id: output
    type: Directory
    doc: path to output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/piscem:0.14.5--he431ac4_0
