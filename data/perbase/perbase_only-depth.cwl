cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - perbase
  - only-depth
label: perbase_only-depth
doc: "Calculate the only the depth at each base\n\nTool homepage: https://github.com/sstadick/perbase"
inputs:
  - id: reads
    type: File
    doc: Input indexed BAM/CRAM to analyze
    inputBinding:
      position: 1
  - id: bcf_file
    type:
      - 'null'
      - File
    doc: A BCF/VCF file containing positions of interest. If specified, only bases
      from the given positions will be reported on.
    inputBinding:
      position: 102
      prefix: --bcf-file
  - id: bed_file
    type:
      - 'null'
      - File
    doc: A BED file containing regions of interest. If specified, only bases from
      the given regions will be reported on
    inputBinding:
      position: 102
      prefix: --bed-file
  - id: bed_format
    type:
      - 'null'
      - boolean
    doc: Output BED-like output format with the depth in the 5th column. Note, `-z`
      can be used with this to change coordinates to 0-based to be more BED-like
    inputBinding:
      position: 102
      prefix: --bed-format
  - id: bgzip
    type:
      - 'null'
      - boolean
    doc: Optionally bgzip the output
    inputBinding:
      position: 102
      prefix: --bgzip
  - id: channel_size_modifier
    type:
      - 'null'
      - float
    doc: The fraction of a gigabyte to allocate per thread for message passing, can
      be greater than 1.0
    default: 0.001
    inputBinding:
      position: 102
      prefix: --channel-size-modifier
  - id: chunksize
    type:
      - 'null'
      - int
    doc: The ideal number of basepairs each worker receives. Total bp in memory at
      one time is (threads - 2) * chunksize
    default: 1000000
    inputBinding:
      position: 102
      prefix: --chunksize
  - id: compression_level
    type:
      - 'null'
      - int
    doc: The level to use for compressing output (specified by --bgzip)
    default: 2
    inputBinding:
      position: 102
      prefix: --compression-level
  - id: compression_threads
    type:
      - 'null'
      - int
    doc: The number of threads to use for compressing output (specified by --bgzip)
    default: 4
    inputBinding:
      position: 102
      prefix: --compression-threads
  - id: exclude_flags
    type:
      - 'null'
      - int
    doc: SAM flags to exclude, recommended 3848
    default: 0
    inputBinding:
      position: 102
      prefix: --exclude-flags
  - id: fast_mode
    type:
      - 'null'
      - boolean
    doc: Calculate depth based only on read starts/stops, see docs for full details
    inputBinding:
      position: 102
      prefix: --fast-mode
  - id: include_flags
    type:
      - 'null'
      - int
    doc: SAM flags to include
    default: 0
    inputBinding:
      position: 102
      prefix: --include-flags
  - id: keep_zeros
    type:
      - 'null'
      - boolean
    doc: Keep positions even if they have 0 depth
    inputBinding:
      position: 102
      prefix: --keep-zeros
  - id: mate_fix
    type:
      - 'null'
      - boolean
    doc: Fix overlapping mates counts, see docs for full details
    inputBinding:
      position: 102
      prefix: --mate-fix
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimum MAPQ for a read to count toward depth
    default: 0
    inputBinding:
      position: 102
      prefix: --min-mapq
  - id: no_merge
    type:
      - 'null'
      - boolean
    doc: Skip merging adjacent bases that have the same depth
    inputBinding:
      position: 102
      prefix: --no-merge
  - id: ref_fasta
    type:
      - 'null'
      - File
    doc: Indexed reference fasta, set if using CRAM
    inputBinding:
      position: 102
      prefix: --ref-fasta
  - id: skip_merging_intervals
    type:
      - 'null'
      - boolean
    doc: Skip mergeing togther regions specified in the optional BED or BCF/VCF files.
    inputBinding:
      position: 102
      prefix: --skip-merging-intervals
  - id: threads
    type:
      - 'null'
      - int
    doc: The number of threads to use
    default: 40
    inputBinding:
      position: 102
      prefix: --threads
  - id: zero_base
    type:
      - 'null'
      - boolean
    doc: Output positions as 0-based instead of 1-based
    inputBinding:
      position: 102
      prefix: --zero-base
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output path, defaults to stdout
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perbase:1.2.0--h15397dd_0
