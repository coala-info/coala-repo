cwlVersion: v1.2
class: CommandLineTool
baseCommand: twilight
label: twilight
doc: "TWILIGHT Command Line Arguments:\n\nTool homepage: https://github.com/TurakhiaLab/TWILIGHT"
inputs:
  - id: add_new_sequences_to_existing_msa
    type:
      - 'null'
      - boolean
    doc: Add New Sequences to Existing MSA
    inputBinding:
      position: 101
  - id: backbone_alignments
    type:
      - 'null'
      - File
    doc: 'Backbone alignments (FASTA format): required for [3].'
    inputBinding:
      position: 101
      prefix: --alignment
  - id: blosum_matrix
    type:
      - 'null'
      - string
    doc: 'BLOSUM matrix to use for protein sequences: 45, 62, or 80.'
    default: '62'
    inputBinding:
      position: 101
      prefix: --blosum
  - id: build_msa_from_unaligned_sequences
    type:
      - 'null'
      - boolean
    doc: Build MSA From Unaligned Sequences
    inputBinding:
      position: 101
  - id: check_alignment
    type:
      - 'null'
      - boolean
    doc: Check the final alignment. Sequences with no legal alignment will be 
      displayed.
    inputBinding:
      position: 101
      prefix: --check
  - id: compress_output
    type:
      - 'null'
      - boolean
    doc: Write output files in compressed (.gz) format
    inputBinding:
      position: 101
      prefix: --compress
  - id: cpu_cores
    type:
      - 'null'
      - int
    doc: 'Number of CPU cores. Default: all available cores.'
    inputBinding:
      position: 101
      prefix: --cpu
  - id: cpu_only
    type:
      - 'null'
      - boolean
    doc: Run the program only on CPU.
    inputBinding:
      position: 101
      prefix: --cpu-only
  - id: data_type
    type:
      - 'null'
      - string
    doc: 'Data type. n: nucleotide, p: protein. Will be automatically inferred if
      not provided.'
    inputBinding:
      position: 101
      prefix: --type
  - id: filter_sequences
    type:
      - 'null'
      - boolean
    doc: Exclude sequences with high ambiguity or length deviation.
    inputBinding:
      position: 101
      prefix: --filter
  - id: gap_ends_penalty
    type:
      - 'null'
      - int
    doc: Gap penalty at ends, default set to the same as the gap extension 
      penalty.
    inputBinding:
      position: 101
      prefix: --gap-ends
  - id: gap_extend_penalty
    type:
      - 'null'
      - int
    doc: Gap-Extend penalty.
    default: -5
    inputBinding:
      position: 101
      prefix: --gap-extend
  - id: gap_open_penalty
    type:
      - 'null'
      - int
    doc: Gap-Open penalty.
    default: -50
    inputBinding:
      position: 101
      prefix: --gap-open
  - id: gpu_count
    type:
      - 'null'
      - int
    doc: 'Number of GPUs. Default: all available GPUs.'
    inputBinding:
      position: 101
      prefix: --gpu
  - id: gpu_index
    type:
      - 'null'
      - string
    doc: Specify the GPU to be used, separated by commas. Ex. 0,2,3
    inputBinding:
      position: 101
      prefix: --gpu-index
  - id: guide_tree
    type:
      - 'null'
      - File
    doc: 'Guide tree (Newick format): required for [1]; optional for [3].'
    inputBinding:
      position: 101
      prefix: --tree
  - id: keep_temp
    type:
      - 'null'
      - boolean
    doc: Keep the temporary directory.
    inputBinding:
      position: 101
      prefix: --keep-temp
  - id: length_deviation_fraction
    type:
      - 'null'
      - float
    doc: Sequences whose lengths deviate from the median by more than the 
      specified fraction will be deferred or excluded.
    inputBinding:
      position: 101
      prefix: --length-deviation
  - id: match_score
    type:
      - 'null'
      - int
    doc: Match score.
    default: 18
    inputBinding:
      position: 101
      prefix: --match
  - id: max_ambiguity_proportion
    type:
      - 'null'
      - float
    doc: Sequences with an ambiguous character proportion exceeding the 
      specified threshold will be deferred or excluded.
    default: 0.100000001
    inputBinding:
      position: 101
      prefix: --max-ambig
  - id: max_sequence_length
    type:
      - 'null'
      - int
    doc: Sequences longer than max-len will be deferred or excluded.
    inputBinding:
      position: 101
      prefix: --max-len
  - id: max_subtree_leaves
    type:
      - 'null'
      - int
    doc: Maximum number of leaves in a subtree.
    inputBinding:
      position: 101
      prefix: --max-subtree
  - id: merge_multiple_msas
    type:
      - 'null'
      - boolean
    doc: Merge Multiple MSAs
    inputBinding:
      position: 101
  - id: min_sequence_length
    type:
      - 'null'
      - int
    doc: Sequences shorter than min-len will be deferred or excluded.
    inputBinding:
      position: 101
      prefix: --min-len
  - id: mismatch_penalty
    type:
      - 'null'
      - int
    doc: Mismatch penalty for transversions.
    default: -8
    inputBinding:
      position: 101
      prefix: --mismatch
  - id: msa_files_directory
    type:
      - 'null'
      - Directory
    doc: 'Directory containing all MSA files. MSA files (FASTA format): required for
      [2].'
    inputBinding:
      position: 101
      prefix: --files
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Force overwriting the output file.
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: prune
    type:
      - 'null'
      - boolean
    doc: Prune the input guide tree based on the presence of unaligned 
      sequences.
    inputBinding:
      position: 101
      prefix: --prune
  - id: remove_gappy_threshold
    type:
      - 'null'
      - float
    doc: Threshold for removing gappy columns. Set to 1 to disable this feature.
    default: 0.949999988
    inputBinding:
      position: 101
      prefix: --remove-gappy
  - id: rooted
    type:
      - 'null'
      - boolean
    doc: Keep the original tree root (disable automatic re-rooting for 
      parallelism)
    inputBinding:
      position: 101
      prefix: --rooted
  - id: substitution_matrix
    type:
      - 'null'
      - string
    doc: Use a user-defined substitution matrix (only for nucleotide).
    inputBinding:
      position: 101
      prefix: --matrix
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Directory for storing temporary files.
    inputBinding:
      position: 101
      prefix: --temp-dir
  - id: transition_score
    type:
      - 'null'
      - int
    doc: Score for transitions.
    default: -4
    inputBinding:
      position: 101
      prefix: --transition
  - id: unaligned_sequences_file
    type:
      - 'null'
      - File
    doc: 'Unaligned sequences file (FASTA format): required for [1] and [3].'
    inputBinding:
      position: 101
      prefix: --sequences
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print out every detail process.
    inputBinding:
      position: 101
      prefix: --verbose
  - id: wildcard
    type:
      - 'null'
      - boolean
    doc: Treat unknown or ambiguous bases as wildcards and align them to usual 
      letters.
    inputBinding:
      position: 101
      prefix: --wildcard
  - id: write_filtered_sequences
    type:
      - 'null'
      - boolean
    doc: Write the filtered sequences in FASTA format to the output directory.
    inputBinding:
      position: 101
      prefix: --write-filtered
  - id: write_pruned_tree
    type:
      - 'null'
      - boolean
    doc: Write the pruned tree to the output directory.
    inputBinding:
      position: 101
      prefix: --write-prune
  - id: xdrop_value
    type:
      - 'null'
      - int
    doc: X-drop value (scale). The actual X-drop will be multiplied by the 
      gap-extend penalty.
    default: 600
    inputBinding:
      position: 101
      prefix: --xdrop
outputs:
  - id: output_file
    type: File
    doc: Output file name (required).
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/twilight:0.2.3--h6bb9b41_1
