cwlVersion: v1.2
class: CommandLineTool
baseCommand: minimap
label: spectrassembler_minimap
doc: "Minimap is a versatile read aligner for long, noisy reads.\n\nTool homepage:
  https://github.com/antrec/spectrassembler"
inputs:
  - id: target_file
    type: File
    doc: Target FASTA file
    inputBinding:
      position: 1
  - id: query_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Query FASTA file(s)
    inputBinding:
      position: 2
  - id: bandwidth
    type:
      - 'null'
      - int
    doc: bandwidth
    inputBinding:
      position: 103
      prefix: -r
  - id: drop_isolated_hits
    type:
      - 'null'
      - boolean
    doc: drop isolated hits before chaining (EXPERIMENTAL)
    inputBinding:
      position: 103
      prefix: -O
  - id: dump_index_file
    type:
      - 'null'
      - File
    doc: dump index to FILE
    inputBinding:
      position: 103
      prefix: -d
  - id: filter_potential_repeats
    type:
      - 'null'
      - boolean
    doc: filtering potential repeats after mapping (EXPERIMENTAL)
    inputBinding:
      position: 103
      prefix: -P
  - id: filter_repetitive_minimizers
    type:
      - 'null'
      - float
    doc: filter out top FLOAT fraction of repetitive minimizers
    inputBinding:
      position: 103
      prefix: -f
  - id: index_split_size
    type:
      - 'null'
      - string
    doc: split index for every ~NUM input bases
    inputBinding:
      position: 103
      prefix: -I
  - id: is_index_file
    type:
      - 'null'
      - boolean
    doc: the 1st argument is a index file (overriding -k, -w and -I)
    inputBinding:
      position: 103
      prefix: -l
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: k-mer size
    inputBinding:
      position: 103
      prefix: -k
  - id: max_gap_length
    type:
      - 'null'
      - int
    doc: split a mapping if there is a gap longer than INT
    inputBinding:
      position: 103
      prefix: -g
  - id: merge_chains_fraction
    type:
      - 'null'
      - float
    doc: merge two chains if FLOAT fraction of minimizers are shared
    inputBinding:
      position: 103
      prefix: -m
  - id: min_matching_length
    type:
      - 'null'
      - int
    doc: min matching length
    inputBinding:
      position: 103
      prefix: -L
  - id: min_minimizers_for_mapping
    type:
      - 'null'
      - int
    doc: retain a mapping if it consists of >=INT minimizers
    inputBinding:
      position: 103
      prefix: -c
  - id: minizer_window_size
    type:
      - 'null'
      - int
    doc: minizer window size
    inputBinding:
      position: 103
      prefix: -w
  - id: preset
    type:
      - 'null'
      - string
    doc: preset (recommended to be applied before other options)
    inputBinding:
      position: 103
      prefix: -x
  - id: sdust_threshold
    type:
      - 'null'
      - int
    doc: SDUST threshold; 0 to disable SDUST
    inputBinding:
      position: 103
      prefix: -T
  - id: skip_self_dual_mappings
    type:
      - 'null'
      - boolean
    doc: skip self and dual mappings
    inputBinding:
      position: 103
      prefix: -S
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 103
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spectrassembler:0.0.1a1--py27_1
stdout: spectrassembler_minimap.out
