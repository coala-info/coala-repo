cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqmap
label: seqmap
doc: "A tool for mapping short sequences to a reference genome, allowing for a specified
  number of mismatches or insertions/deletions.\n\nTool homepage: http://biogibbs.stanford.edu/~jiangh/SeqMap/"
inputs:
  - id: mismatches
    type: int
    doc: Maximum edit distance allowed
    inputBinding:
      position: 1
  - id: probe_file
    type: File
    doc: Probe/tag/read sequences (FASTA)
    inputBinding:
      position: 2
  - id: transcript_file
    type: File
    doc: Reference sequences (FASTA)
    inputBinding:
      position: 3
  - id: output_file
    type: string
    doc: Name of the output file
    inputBinding:
      position: 4
  - id: eland
    type:
      - 'null'
      - boolean
    doc: Output in eland style
    inputBinding:
      position: 5
      prefix: /eland
  - id: forward_strand
    type:
      - 'null'
      - boolean
    doc: Search forward strand only
    inputBinding:
      position: 5
      prefix: /forward_strand
  - id: match_shorter_probes
    type:
      - 'null'
      - boolean
    doc: Match shorter probes
    inputBinding:
      position: 5
      prefix: /match_shorter_probes
  - id: skip_n
    type:
      - 'null'
      - boolean
    doc: Skip probes that have N or .
    inputBinding:
      position: 5
      prefix: /skip_N
  - id: no_repeats
    type:
      - 'null'
      - boolean
    doc: Do not search repeat regions
    inputBinding:
      position: 5
      prefix: /no_repeats
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Disable debug information
    inputBinding:
      position: 5
      prefix: /silent
  - id: zero_indexed
    type:
      - 'null'
      - boolean
    doc: Output coordinates in 0-indexed manner
    inputBinding:
      position: 5
      prefix: /zero_indexed
  - id: output_all_matches
    type:
      - 'null'
      - boolean
    doc: Output all matches
    inputBinding:
      position: 5
      prefix: /output_all_matches
  - id: exact_mismatch
    type:
      - 'null'
      - boolean
    doc: Output targets with exact number of mismatches only
    inputBinding:
      position: 5
      prefix: /exact_mismatch
  - id: output_alignment
    type:
      - 'null'
      - boolean
    doc: Output alignment (advanced)
    inputBinding:
      position: 5
      prefix: /output_alignment
  - id: output_statistics
    type:
      - 'null'
      - boolean
    doc: Output in probe order (advanced)
    inputBinding:
      position: 5
      prefix: /output_statistics
  - id: do_not_output_probe_without_match
    type:
      - 'null'
      - boolean
    doc: Ignore non-matched probes (advanced)
    inputBinding:
      position: 5
      prefix: /do_not_output_probe_without_match
  - id: no_duplicate_probes
    type:
      - 'null'
      - boolean
    doc: Do not duplicate probes for reverse strand search (advanced)
    inputBinding:
      position: 5
      prefix: /no_duplicate_probes
  - id: use_hash
    type:
      - 'null'
      - boolean
    doc: Use hash if possible (advanced)
    inputBinding:
      position: 5
      prefix: /use_hash
  - id: no_hash_1bp_mismatch
    type:
      - 'null'
      - boolean
    doc: Do not use hash for 1bp search (advanced)
    inputBinding:
      position: 5
      prefix: /no_hash_1bp_mismatch
  - id: interpolation_search
    type:
      - 'null'
      - boolean
    doc: Use interpolation search, not binary search (advanced)
    inputBinding:
      position: 5
      prefix: /interpolation_search
  - id: shift_mask
    type:
      - 'null'
      - boolean
    doc: May reduce memory usage while increase running time (advanced)
    inputBinding:
      position: 5
      prefix: /shift_mask
  - id: no_store_key
    type:
      - 'null'
      - boolean
    doc: May reduce memory usage while increase running time (advanced)
    inputBinding:
      position: 5
      prefix: /no_store_key
  - id: no_fast_index
    type:
      - 'null'
      - boolean
    doc: May reduce memory usage while increase running time (advanced)
    inputBinding:
      position: 5
      prefix: /no_fast_index
  - id: no_filter_results
    type:
      - 'null'
      - boolean
    doc: Do not filter results (advanced)
    inputBinding:
      position: 5
      prefix: /no_filter_results
  - id: output_filtered_probes
    type:
      - 'null'
      - boolean
    doc: Output the filtered probes (advanced)
    inputBinding:
      position: 5
      prefix: /output_filtered_probes
  - id: filter_low_quality_probes
    type:
      - 'null'
      - boolean
    doc: Filter low quality probes (advanced)
    inputBinding:
      position: 5
      prefix: /filter_low_quality_probes
  - id: eland_style
    type:
      - 'null'
      - string
    doc: Output in eland style, with the given style
    inputBinding:
      position: 5
      prefix: '/eland:'
      separate: false
  - id: output_top_matches
    type:
      - 'null'
      - int
    doc: Output the top num_top_matches targets
    inputBinding:
      position: 5
      prefix: '/output_top_matches:'
      separate: false
  - id: allow_insdel
    type:
      - 'null'
      - int
    doc: Enable insertion and deletion (maximum number of indels)
    inputBinding:
      position: 5
      prefix: '/allow_insdel:'
      separate: false
  - id: cut
    type:
      - 'null'
      - string
    doc: Cut the probes (start,end)
    inputBinding:
      position: 5
      prefix: '/cut:'
      separate: false
  - id: available_memory
    type:
      - 'null'
      - int
    doc: Disable memory detection and set memory size manually (in MB)
    inputBinding:
      position: 5
      prefix: '/available_memory:'
      separate: false
  - id: limit_num_part
    type:
      - 'null'
      - int
    doc: Maximum number of parts that a probe is splitted (advanced)
    inputBinding:
      position: 5
      prefix: '/limit_num_part:'
      separate: false
  - id: fast_index_fraction
    type:
      - 'null'
      - float
    doc: Fast index fraction (advanced)
    inputBinding:
      position: 5
      prefix: '/fast_index_fraction:'
      separate: false
  - id: filter_selected_probes
    type:
      - 'null'
      - File
    doc: Remove the probes in the given file (advanced)
    inputBinding:
      position: 5
      prefix: '/filter_selected_probes:'
      separate: false
outputs:
  - id: mapping_output
    type: File
    doc: Mapping result file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqmap:1.0.13--h9948957_3
