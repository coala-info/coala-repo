cwlVersion: v1.2
class: CommandLineTool
baseCommand: HPC.REPmask
label: damasker_HPC.REPmask
doc: "Write a shell script that runs daligner and REPmask over groups of blocks of
  a split DAZZ_DB database to build a repeat mask track. The script is written
  to standard output, or to bundle files with -f.\n\nTool homepage:
  https://github.com/thegenemyers/DAMASKER"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Run all commands in script in verbose mode.
    inputBinding:
      position: 1
      prefix: -v
  - id: compensate_kmer_counts
    type:
      - 'null'
      - boolean
    doc: For AT/GC biased data, compensate k-mer counts (deprecated).
    inputBinding:
      position: 1
      prefix: -b
  - id: output_subdir
    type:
      - 'null'
      - boolean
    doc: Put .las files for each target block in a sub-directory
    inputBinding:
      position: 1
      prefix: -d
  - id: ignore_frequent_kmer_threshold
    type:
      - 'null'
      - int
    doc: Ignore k-mers that occur >= -t times in a block.
    inputBinding:
      position: 1
      prefix: -t
      separate: false
  - id: overlap_band_width
    type:
      - 'null'
      - int
    doc: Look for k-mers in overlapping bands of size 2^-w. Default 6.
    inputBinding:
      position: 1
      prefix: -w
      separate: false
  - id: min_alignment_length
    type:
      - 'null'
      - int
    doc: Look for alignments of length >= -l. Default 1000.
    inputBinding:
      position: 1
      prefix: -l
      separate: false
  - id: trace_point_spacing
    type:
      - 'null'
      - int
    doc: Use -s as the trace point spacing for encoding alignments. Default 100.
    inputBinding:
      position: 1
      prefix: -s
      separate: false
  - id: memory_limit_gb
    type:
      - 'null'
      - int
    doc: Use only -M GB of memory by ignoring most frequent k-mers.
    inputBinding:
      position: 1
      prefix: -M
      separate: false
  - id: repeat_mask_track_name
    type:
      - 'null'
      - string
    doc: Use this name for the repeat mask track. Default rep-g.
    inputBinding:
      position: 1
      prefix: -n
      separate: false
  - id: first_level_sort_dir
    type:
      - 'null'
      - string
    doc: Do first level sort and merge in directory -P. Default /tmp.
    inputBinding:
      position: 1
      prefix: -P
      separate: false
  - id: daligner_job_block_compares
    type:
      - 'null'
      - int
    doc: Number of block compares per daligner job. Default 4.
    inputBinding:
      position: 1
      prefix: -B
      separate: false
  - id: threads
    type:
      - 'null'
      - int
    doc: Use -T threads. Default 4.
    inputBinding:
      position: 1
      prefix: -T
      separate: false
  - id: script_bundle_prefix
    type:
      - 'null'
      - string
    doc: Place script bundles in separate files with prefix <name>
    inputBinding:
      position: 1
      prefix: -f
      separate: false
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: k-mer size (must be <= 32). Default 14.
    inputBinding:
      position: 1
      prefix: -k
      separate: false
  - id: min_seed_hit_bps
    type:
      - 'null'
      - int
    doc: A seed hit if the k-mers in band cover >= -h bps in the targest read. Default 35.
    inputBinding:
      position: 1
      prefix: -h
      separate: false
  - id: similarity_percent
    type:
      - 'null'
      - double
    doc: Look for alignments with -e percent similarity. Default .70.
    inputBinding:
      position: 1
      prefix: -e
      separate: false
  - id: soft_mask_track
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -m
          separate: false
    doc: Soft mask the blocks with the specified mask.
    inputBinding:
      position: 1
  - id: comparison_group_blocks
    type: int
    doc: Number of blocks per comparison group.
    inputBinding:
      position: 1
      prefix: -g
      separate: false
  - id: coverage_threshold
    type: int
    doc: Coverage threshold for repeat intervals.
    inputBinding:
      position: 1
      prefix: -c
      separate: false
  - id: reads_or_dam
    type: File
    doc: Reads database (.db or .dam), split into blocks with DBsplit
    inputBinding:
      position: 2
    secondaryFiles:
      - pattern: '${ return "." + self.nameroot + ".idx"; }'
      - pattern: '${ return "." + self.nameroot + ".bps"; }'
      - pattern: '${ return "." + self.nameroot + ".hdr"; }'
        required: false
  - id: block_range
    type:
      - 'null'
      - string
    doc: Only handle blocks <block>[-<range>]
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Shell script with the daligner and REPmask commands
  - id: bundle_files
    type:
      type: array
      items: File
    doc: Script bundle files written when script_bundle_prefix is given
    outputBinding:
      glob: '$(inputs.script_bundle_prefix ? inputs.script_bundle_prefix + ".*" : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/damasker:1.0p1--h7b50bb2_8
stdout: damasker_HPC.REPmask.out
