cwlVersion: v1.2
class: CommandLineTool
baseCommand: HPC.REPmask
label: damasker_HPC.REPmask
doc: "HPC.REPmask is a script that runs daligner and REPmask.\n\nTool homepage: https://github.com/thegenemyers/DAMASKER"
inputs:
  - id: reads_or_dam
    type: string
    doc: Input reads:db or dam
    inputBinding:
      position: 1
  - id: block_range
    type:
      - 'null'
      - string
    doc: Block and range for comparison
    inputBinding:
      position: 2
  - id: comparison_group_blocks
    type: int
    doc: '# of blocks per comparison group.'
    inputBinding:
      position: 103
      prefix: -g
  - id: compensate_kmer_counts
    type:
      - 'null'
      - boolean
    doc: For AT/GC biased data, compensate k-mer counts (deprecated).
    inputBinding:
      position: 103
      prefix: -b
  - id: coverage_threshold
    type: int
    doc: Coverage threshold for repeat intervals.
    inputBinding:
      position: 103
      prefix: -c
  - id: daligner_job_block_compares
    type:
      - 'null'
      - int
    doc: '# of block compares per daligner job'
    inputBinding:
      position: 103
      prefix: -B
  - id: first_level_sort_dir
    type:
      - 'null'
      - Directory
    doc: Do first level sort and merge in directory -P.
    inputBinding:
      position: 103
      prefix: -P
  - id: ignore_frequent_kmer_threshold
    type:
      - 'null'
      - int
    doc: Ignore k-mers that occur >= -t times in a block.
    inputBinding:
      position: 103
      prefix: -t
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: k-mer size (must be <= 32).
    inputBinding:
      position: 103
      prefix: -k
  - id: memory_limit_gb
    type:
      - 'null'
      - int
    doc: Use only -M GB of memory by ignoring most frequent k-mers.
    inputBinding:
      position: 103
      prefix: -M
  - id: min_alignment_length
    type:
      - 'null'
      - int
    doc: Look for alignments of length >= -l.
    inputBinding:
      position: 103
      prefix: -l
  - id: min_seed_hit_bps
    type:
      - 'null'
      - int
    doc: A seed hit if the k-mers in band cover >= -h bps in the targetest read.
    inputBinding:
      position: 103
      prefix: -h
  - id: output_subdir
    type:
      - 'null'
      - boolean
    doc: Put .las files for each target block in a sub-directory
    inputBinding:
      position: 103
      prefix: -d
  - id: overlap_band_width
    type:
      - 'null'
      - int
    doc: Look for k-mers in overlapping bands of size 2^-w.
    inputBinding:
      position: 103
      prefix: -w
  - id: repeat_mask_track_name
    type:
      - 'null'
      - string
    doc: Use this name for the repeat mask track.
    inputBinding:
      position: 103
      prefix: -n
  - id: script_bundle_prefix
    type:
      - 'null'
      - string
    doc: Place script bundles in separate files with prefix <name>
    inputBinding:
      position: 103
      prefix: -f
  - id: similarity_percent
    type:
      - 'null'
      - float
    doc: Look for alignments with -e percent similarity.
    inputBinding:
      position: 103
      prefix: -e
  - id: soft_mask_track
    type:
      - 'null'
      - type: array
        items: string
    doc: Soft mask the blocks with the specified mask.
    inputBinding:
      position: 103
      prefix: -m
  - id: threads
    type:
      - 'null'
      - int
    doc: Use -T threads.
    inputBinding:
      position: 103
      prefix: -T
  - id: trace_point_spacing
    type:
      - 'null'
      - int
    doc: Use -s as the trace point spacing for encoding alignments.
    inputBinding:
      position: 103
      prefix: -s
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Run all commands in script in verbose mode.
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/damasker:1.0p1--h7b50bb2_8
stdout: damasker_HPC.REPmask.out
