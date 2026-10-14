cwlVersion: v1.2
class: CommandLineTool
baseCommand: [piscem, map-sc-atac]
label: piscem_map-sc-atac
doc: "map reads for scAtac processing\n\nTool homepage: https://github.com/COMBINE-lab/piscem"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.index_files)
        writable: true
inputs:
  - id: index_files
    type:
      type: array
      items: File
    doc: 'Index files written by piscem build (all files that share the index prefix); staged in the working directory'
  - id: index
    type: string
    doc: 'input index prefix: the file stem used as output of piscem build, without directory'
    inputBinding:
      position: 101
      prefix: --index
  - id: read1
    type:
      - 'null'
      - type: array
        items: File
    doc: 'read 1 files (joined with commas)'
    inputBinding:
      position: 101
      prefix: --read1
      itemSeparator: ','
  - id: read2
    type:
      - 'null'
      - type: array
        items: File
    doc: 'read 2 files (joined with commas)'
    inputBinding:
      position: 101
      prefix: --read2
      itemSeparator: ','
  - id: reads
    type:
      - 'null'
      - type: array
        items: File
    doc: 'unpaired read files (joined with commas)'
    inputBinding:
      position: 101
      prefix: --reads
      itemSeparator: ','
  - id: barcode
    type:
      - 'null'
      - type: array
        items: File
    doc: 'barcode read files (joined with commas)'
    inputBinding:
      position: 101
      prefix: --barcode
      itemSeparator: ','
  - id: sam_format
    type:
      - 'null'
      - boolean
    doc: 'output mappings in sam format'
    inputBinding:
      position: 101
      prefix: --sam-format
  - id: bed_format
    type:
      - 'null'
      - boolean
    doc: 'output mappings in bed format'
    inputBinding:
      position: 101
      prefix: --bed-format
  - id: use_chr
    type:
      - 'null'
      - boolean
    doc: 'use chromosomes as color'
    inputBinding:
      position: 101
      prefix: --use-chr
  - id: thr
    type:
      - 'null'
      - float
    doc: 'threshold to be considered for pseudoalignment (default 0.7)'
    inputBinding:
      position: 101
      prefix: --thr
  - id: bin_size
    type:
      - 'null'
      - int
    doc: 'size of virtual color (default 1000)'
    inputBinding:
      position: 101
      prefix: --bin-size
  - id: bin_overlap
    type:
      - 'null'
      - int
    doc: 'size for bin overlap (default 300)'
    inputBinding:
      position: 101
      prefix: --bin-overlap
  - id: no_tn5_shift
    type:
      - 'null'
      - boolean
    doc: 'do not apply Tn5 shift to mapped positions'
    inputBinding:
      position: 101
      prefix: --no-tn5-shift
  - id: check_kmer_orphan
    type:
      - 'null'
      - boolean
    doc: 'check if any mapping kmer exists for a mate which is not mapped, but there exists mapping for the other read'
    inputBinding:
      position: 101
      prefix: --check-kmer-orphan
  - id: bclen
    type:
      - 'null'
      - int
    doc: 'length of the barcode sequence (default 16)'
    inputBinding:
      position: 101
      prefix: --bclen
  - id: end_cache_capacity
    type:
      - 'null'
      - int
    doc: 'capacity of the cache used for fast lookup of k-mers at the ends of unitigs (default 5000000)'
    inputBinding:
      position: 101
      prefix: --end-cache-capacity
  - id: threads
    type:
      - 'null'
      - int
    doc: 'number of threads to use'
    inputBinding:
      position: 101
      prefix: --threads
  - id: no_poison
    type:
      - 'null'
      - boolean
    doc: 'do not consider poison k-mers, even if the underlying index contains them'
    inputBinding:
      position: 101
      prefix: --no-poison
  - id: struct_constraints
    type:
      - 'null'
      - boolean
    doc: 'apply structural constraints when performing mapping'
    inputBinding:
      position: 101
      prefix: --struct-constraints
  - id: skipping_strategy
    type:
      - 'null'
      - string
    doc: 'skipping strategy to use for k-mer collection: permissive or strict (default permissive)'
    inputBinding:
      position: 101
      prefix: --skipping-strategy
  - id: ignore_ambig_hits
    type:
      - 'null'
      - boolean
    doc: 'skip checking of the equivalence classes of k-mers that were too ambiguous to be otherwise considered'
    inputBinding:
      position: 101
      prefix: --ignore-ambig-hits
  - id: max_ec_card
    type:
      - 'null'
      - int
    doc: 'maximum cardinality equivalence class to examine (default 4096)'
    inputBinding:
      position: 101
      prefix: --max-ec-card
  - id: max_hit_occ
    type:
      - 'null'
      - int
    doc: 'in the first pass, consider only k-mers having <= this many hits (default 256)'
    inputBinding:
      position: 101
      prefix: --max-hit-occ
  - id: max_hit_occ_recover
    type:
      - 'null'
      - int
    doc: 'if all k-mers have > max-hit-occ hits, make a second pass with k-mers having <= this many hits (default 1024)'
    inputBinding:
      position: 101
      prefix: --max-hit-occ-recover
  - id: max_read_occ
    type:
      - 'null'
      - int
    doc: 'reads with more than this number of mappings will not have their mappings reported (default 2500)'
    inputBinding:
      position: 101
      prefix: --max-read-occ
  - id: output_path
    type: string
    doc: 'path to output directory'
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: Directory
    doc: 'Mapping output directory'
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/piscem:0.14.5--he431ac4_0
