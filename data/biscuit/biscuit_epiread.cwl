cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biscuit
  - epiread
label: biscuit_epiread
doc: "Extract epiread information from a BAM file using a reference genome.\n\nTool
  homepage: https://github.com/huishenlab/biscuit"
inputs:
  - id: reference_fasta
    type: File
    doc: Reference genome FASTA file
    inputBinding:
      position: 1
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 2
  - id: bed_input
    type:
      - 'null'
      - File
    doc: Bed input for SNP display in epiread output
    inputBinding:
      position: 103
      prefix: -B
  - id: double_count_cytosines
    type:
      - 'null'
      - boolean
    doc: Double count cytosines in overlapping mate reads (avoided by default)
    inputBinding:
      position: 103
      prefix: -d
  - id: max_cytosine_retention
    type:
      - 'null'
      - int
    doc: Max cytosine retention in a read
    inputBinding:
      position: 103
      prefix: -t
  - id: max_nm_tag
    type:
      - 'null'
      - int
    doc: Maximum NM tag
    inputBinding:
      position: 103
      prefix: -n
  - id: max_read_length
    type:
      - 'null'
      - int
    doc: maximum read length (will need to be increased for long reads)
    inputBinding:
      position: 103
      prefix: -L
  - id: min_alignment_score
    type:
      - 'null'
      - int
    doc: Minimum alignment score (from AS-tag)
    inputBinding:
      position: 103
      prefix: -a
  - id: min_base_quality
    type:
      - 'null'
      - int
    doc: Minimum base quality
    inputBinding:
      position: 103
      prefix: -b
  - id: min_dist_3p
    type:
      - 'null'
      - int
    doc: Minimum distance to 3' end of a read
    inputBinding:
      position: 103
      prefix: '-3'
  - id: min_dist_5p
    type:
      - 'null'
      - int
    doc: Minimum distance to 5' end of a read
    inputBinding:
      position: 103
      prefix: '-5'
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: Minimum mapping quality
    inputBinding:
      position: 103
      prefix: -m
  - id: min_mod_probability
    type:
      - 'null'
      - float
    doc: Minimum probability a modification is correct (0.0 - 1.0)
    inputBinding:
      position: 103
      prefix: -y
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: Minimum read length
    inputBinding:
      position: 103
      prefix: -l
  - id: mod_bam_tags
    type:
      - 'null'
      - boolean
    doc: BAM file has modBAM tags (MM/ML)
    inputBinding:
      position: 103
      prefix: -M
  - id: no_duplicate_filtering
    type:
      - 'null'
      - boolean
    doc: NO filtering of duplicate
    inputBinding:
      position: 103
      prefix: -u
  - id: no_empty_filtering
    type:
      - 'null'
      - boolean
    doc: NO filtering of empty epireads
    inputBinding:
      position: 103
      prefix: -E
  - id: no_improper_pair_filtering
    type:
      - 'null'
      - boolean
    doc: NO filtering of improper pair
    inputBinding:
      position: 103
      prefix: -p
  - id: nome_seq_mode
    type:
      - 'null'
      - boolean
    doc: NOMe-seq mode
    inputBinding:
      position: 103
      prefix: -N
  - id: old_format
    type:
      - 'null'
      - boolean
    doc: Old BISCUIT epiread format, not compatible with -P
    inputBinding:
      position: 103
      prefix: -O
  - id: pairwise_mode
    type:
      - 'null'
      - boolean
    doc: Pairwise mode
    inputBinding:
      position: 103
      prefix: -P
  - id: print_all_locations
    type:
      - 'null'
      - boolean
    doc: Print all CpG and SNP locations in location column, ignored if -O not given
    inputBinding:
      position: 103
      prefix: -A
  - id: region
    type:
      - 'null'
      - string
    doc: Region (optional, will process the whole bam if not specified)
    inputBinding:
      position: 103
      prefix: -g
  - id: step_size
    type:
      - 'null'
      - int
    doc: Step of window dispatching
    inputBinding:
      position: 103
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 103
      prefix: -@
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose (print additional info for diagnostics)
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biscuit:1.7.1.20250908--hc4b60c0_0
