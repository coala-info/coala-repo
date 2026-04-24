cwlVersion: v1.2
class: CommandLineTool
baseCommand: MBG
label: mbg_MBG
doc: "MBG bioconda 1.0.17\n\nTool homepage: https://github.com/maickrau/MBG"
inputs:
  - id: blunt
    type:
      - 'null'
      - boolean
    doc: Output a bluntified graph without edge overlaps
    inputBinding:
      position: 101
      prefix: --blunt
  - id: copycount_filter_heuristic
    type:
      - 'null'
      - boolean
    doc: Use coverage based heuristic filter during multiplex resolution
    inputBinding:
      position: 101
      prefix: --copycount-filter-heuristic
  - id: do_unsafe_guesswork_resolutions
    type:
      - 'null'
      - boolean
    doc: Use extra heuristics during multiplex resolution
    inputBinding:
      position: 101
      prefix: --do-unsafe-guesswork-resolutions
  - id: error_masking
    type:
      - 'null'
      - string
    doc: Error masking
    inputBinding:
      position: 101
  - id: hpc_variant_onecopy_coverage
    type:
      - 'null'
      - int
    doc: Separate k-mers based on hpc variants, using arg as single copy 
      coverage
    inputBinding:
      position: 101
      prefix: --hpc-variant-onecopy-coverage
  - id: include_end_kmers
    type:
      - 'null'
      - boolean
    doc: Force k-mers at read ends to be included
    inputBinding:
      position: 101
      prefix: --include-end-kmers
  - id: input_reads
    type:
      type: array
      items: File
    doc: Input reads. Multiple files can be input with -i file1.fa -i file2.fa 
      etc
    inputBinding:
      position: 101
      prefix: --in
  - id: keep_gaps
    type:
      - 'null'
      - boolean
    doc: Don't remove low coverage nodes if it would leave a gap in the graph
    inputBinding:
      position: 101
      prefix: --keep-gaps
  - id: keep_sequence_name_tags
    type:
      - 'null'
      - boolean
    doc: Keep tags in input sequence names
    inputBinding:
      position: 101
      prefix: --keep-sequence-name-tags
  - id: kmer_abundance
    type:
      - 'null'
      - int
    doc: Minimum k-mer abundance
    inputBinding:
      position: 101
      prefix: --kmer-abundance
  - id: kmer_size
    type: int
    doc: K-mer size. Must be odd and >=31
    inputBinding:
      position: 101
      prefix: -k
  - id: no_kmer_filter_inside_unitig
    type:
      - 'null'
      - boolean
    doc: Don't filter out k-mers which are completely contained by two other 
      k-mers
    inputBinding:
      position: 101
      prefix: --no-kmer-filter-inside-unitig
  - id: no_multiplex_cleaning
    type:
      - 'null'
      - boolean
    doc: Don't clean low coverage tips and structures during multiplex 
      resolution
    inputBinding:
      position: 101
      prefix: --no-multiplex-cleaning
  - id: node_name_prefix
    type:
      - 'null'
      - string
    doc: Add a prefix to output node names
    inputBinding:
      position: 101
      prefix: --node-name-prefix
  - id: only_local_resolve
    type:
      - 'null'
      - boolean
    doc: Only resolve nodes which are repetitive within a read
    inputBinding:
      position: 101
      prefix: --only-local-resolve
  - id: resolve_maxk
    type:
      - 'null'
      - int
    doc: Maximum k-mer size for multiplex DBG resolution
    inputBinding:
      position: 101
      prefix: --resolve-maxk
  - id: resolve_maxk_allowgaps
    type:
      - 'null'
      - int
    doc: Allow multiplex resolution to add gaps up to this k-mer size
    inputBinding:
      position: 101
      prefix: --resolve-maxk-allowgaps
  - id: resolve_palindromes_global
    type:
      - 'null'
      - boolean
    doc: Resolve palindromic nodes even if their length is above the local 
      resolution length
    inputBinding:
      position: 101
      prefix: --resolve-palindromes-global
  - id: sequence_cache_file
    type:
      - 'null'
      - File
    doc: Use a temporary sequence cache file to speed up graph construction
    inputBinding:
      position: 101
      prefix: --sequence-cache-file
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
  - id: unitig_abundance
    type:
      - 'null'
      - int
    doc: Minimum average unitig abundance
    inputBinding:
      position: 101
      prefix: --unitig-abundance
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size. Must be 1 <= w <= k-30
    inputBinding:
      position: 101
      prefix: -w
outputs:
  - id: output_graph
    type: File
    doc: Output graph
    outputBinding:
      glob: $(inputs.output_graph)
  - id: output_sequence_paths
    type:
      - 'null'
      - File
    doc: Output the paths of the input sequences to a file (.gaf)
    outputBinding:
      glob: $(inputs.output_sequence_paths)
  - id: output_homology_map
    type:
      - 'null'
      - File
    doc: Output a list of homologous k-mer locations
    outputBinding:
      glob: $(inputs.output_homology_map)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mbg:1.0.17--h06902ac_0
