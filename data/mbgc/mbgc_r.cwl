cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mbgc
  - r
label: mbgc_r
doc: "Repack selected FASTA files from an existing MBGC archive into a new archive\n\nTool homepage: https://github.com/kowallus/mbgc"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: archive_file
    type: File
    doc: "mbgc archive filename for repacking"
    inputBinding:
      position: 1
  - id: output_archive_path
    type: string
    doc: "name of repacked mbgc archive"
    inputBinding:
      position: 2
  - id: compression_mode
    type:
      - 'null'
      - int
    doc: "compression mode (speed: 0; default: 1; repo: 2; max: 3)"
    inputBinding:
      position: 102
      prefix: -m
  - id: lossy
    type:
      - 'null'
      - boolean
    doc: "allow lossy compression"
    inputBinding:
      position: 102
      prefix: -L
  - id: force
    type:
      - 'null'
      - boolean
    doc: "overwrite an existing output file"
    inputBinding:
      position: 102
      prefix: -f
  - id: bases_per_row
    type:
      - 'null'
      - int
    doc: "custom format of repacked DNA (0 - unlimited)"
    inputBinding:
      position: 102
      prefix: -l
  - id: exclude_pattern
    type:
      - 'null'
      - string
    doc: "exclude files with names not containing pattern"
    inputBinding:
      position: 102
      prefix: -e
  - id: exclude_patterns_file
    type:
      - 'null'
      - File
    doc: "exclude files not matching any pattern (name of text file with list of patterns in separate lines)"
    inputBinding:
      position: 102
      prefix: -E
  - id: threads
    type:
      - 'null'
      - int
    doc: "set limit of used threads"
    inputBinding:
      position: 102
      prefix: -t
  - id: ignore_fasta_paths
    type:
      - 'null'
      - boolean
    doc: "ignore FASTA file paths (use only filenames)"
    inputBinding:
      position: 102
      prefix: -I
  - id: redirect_stderr
    type:
      - 'null'
      - boolean
    doc: "redirect app output to stderr"
    inputBinding:
      position: 102
      prefix: '-2'
  - id: matcher_workers
    type:
      - 'null'
      - int
    doc: "worker threads used by matcher (default: 8)"
    inputBinding:
      position: 102
      prefix: -T
  - id: uppercase
    type:
      - 'null'
      - boolean
    doc: "converts bases to uppercase"
    inputBinding:
      position: 102
      prefix: -U
  - id: disable_parallel_matching
    type:
      - 'null'
      - boolean
    doc: "disable parallel matching (does not apply to I/O and backend compression)"
    inputBinding:
      position: 102
      prefix: -Q
  - id: matching_kmer_length
    type:
      - 'null'
      - int
    doc: "matching k-mer length (16 <= k <= 40, default: 32)"
    inputBinding:
      position: 102
      prefix: -k
  - id: unmatched_fraction_factor
    type:
      - 'null'
      - int
    doc: "unmatched fraction factor (1 <= u <= 255, default: 128)"
    inputBinding:
      position: 102
      prefix: -u
  - id: unmatched_fraction_rc_factor
    type:
      - 'null'
      - int
    doc: "unmatched fraction RC factor (0 <= r <= 255, default: 8, 0 disables rc-matches in reference)"
    inputBinding:
      position: 102
      prefix: -r
  - id: reference_sampling_step
    type:
      - 'null'
      - int
    doc: "reference sampling step (s > 0, default: 16)"
    inputBinding:
      position: 102
      prefix: -s
  - id: reference_factor_binary_order
    type:
      - 'null'
      - int
    doc: "reference factor binary order (0 <= o <= 12, auto-adjusted by default)"
    inputBinding:
      position: 102
      prefix: -o
  - id: disable_circular_reference
    type:
      - 'null'
      - boolean
    doc: "disable circular reference buffer"
    inputBinding:
      position: 102
      prefix: -C
  - id: gap_depth_offset_encoding
    type:
      - 'null'
      - int
    doc: "gap depth offset encoding (0 <= g <= 128, default: 64, 0 - disable)"
    inputBinding:
      position: 102
      prefix: -g
  - id: gap_breaking_match_min_length
    type:
      - 'null'
      - int
    doc: "gap breaking match minimal length (b > 0, default: 256, 0 - disable)"
    inputBinding:
      position: 102
      prefix: -b
  - id: max_consecutive_mismatches
    type:
      - 'null'
      - int
    doc: "maximum consecutive mismatches (0 <= x <= 255, default: 10; 0 - disable; 1 - single mismatch mode)"
    inputBinding:
      position: 102
      prefix: -x
  - id: disable_mismatch_exclusion
    type:
      - 'null'
      - boolean
    doc: "disable encoding mismatches with exclusion"
    inputBinding:
      position: 102
      prefix: -X
  - id: rc_match_min_length
    type:
      - 'null'
      - int
    doc: "reverse-complement match minimal length (R >= 24, default: 0, 0 - disable)"
    inputBinding:
      position: 102
      prefix: -R
outputs:
  - id: archive
    type: File
    doc: 'The repacked archive'
    outputBinding:
      glob: $(inputs.output_archive_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mbgc:2.1.1--hd63eeec_0
