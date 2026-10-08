cwlVersion: v1.2
class: CommandLineTool
baseCommand: goldrush-path
label: goldrush_goldrush_path
doc: "Find golden paths (or silver paths) from long reads with GoldRush-Path, the
  first step of the GoldRush long-read genome assembler.\n\nTool homepage: https://github.com/bcgsc/goldrush"
inputs:
  - id: input_reads
    type: File
    doc: Find golden paths from INPUT (FASTQ or FASTA reads)
    inputBinding:
      position: 101
      prefix: -i
  - id: genome_size
    type: string
    doc: Estimated genome size in bp (for example 3e9)
    inputBinding:
      position: 101
      prefix: -g
  - id: k
    type: int
    doc: Span of spaced seed
    inputBinding:
      position: 101
      prefix: -k
  - id: w
    type: int
    doc: Weight of spaced seed
    inputBinding:
      position: 101
      prefix: -w
  - id: insert_tiles
    type:
      - 'null'
      - int
    doc: During insertion, B number of consecutive tiles to be inserted with the 
      same ID [10]
    inputBinding:
      position: 101
      prefix: -b
  - id: max_phred_delta
    type:
      - 'null'
      - int
    doc: Remove reads with greater or equal than D phred average between first 
      half and second half of the read [5]
    inputBinding:
      position: 101
      prefix: -d
  - id: exclude_reads
    type:
      - 'null'
      - File
    doc: Do not use reads listed in F. Expects one read per line
    inputBinding:
      position: 101
      prefix: -f
  - id: occupancy
    type:
      - 'null'
      - float
    doc: Use O as occupancy [0.1]
    inputBinding:
      position: 101
      prefix: -o
  - id: num_seed_patterns
    type:
      - 'null'
      - int
    doc: Use h as number of spaced seed patterns [1]
    inputBinding:
      position: 101
      prefix: -h
  - id: hash_universe
    type:
      - 'null'
      - string
    doc: Determine MiBF size based on HASH_UNIVERSE [Calculated based on W and h]
    inputBinding:
      position: 101
      prefix: -H
  - id: tile_length
    type:
      - 'null'
      - int
    doc: Tile length [1000]
    inputBinding:
      position: 101
      prefix: -t
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: Use reads longer than M [20000]
    inputBinding:
      position: 101
      prefix: -m
  - id: min_unassigned_tiles
    type:
      - 'null'
      - int
    doc: U minimum unassigned tiles for read to be unassigned [5]
    inputBinding:
      position: 101
      prefix: -u
  - id: max_assigned_tiles
    type:
      - 'null'
      - int
    doc: A maximum assigned tiles for read to be unassigned [1]
    inputBinding:
      position: 101
      prefix: -a
  - id: prefix
    type: string
    default: goldrush_out
    doc: Write output to files with this prefix [goldrush_out]
    inputBinding:
      position: 101
      prefix: -p
  - id: min_phred_avg
    type:
      - 'null'
      - int
    doc: Minimum average phred score for each read [0 (calculates phred score 
      minimum automatically)]
    inputBinding:
      position: 101
      prefix: -P
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads [48]
    inputBinding:
      position: 101
      prefix: -j
  - id: seed_preset
    type:
      - 'null'
      - string
    doc: Use S seed preset. Must be consistent with k and w [n/a, generate one 
      randomly based on k and w]
    inputBinding:
      position: 101
      prefix: -s
  - id: min_hits
    type:
      - 'null'
      - int
    doc: Require X hits for a tile to be assigned [10]
    inputBinding:
      position: 101
      prefix: -x
  - id: max_paths
    type:
      - 'null'
      - int
    doc: Output MAX_PATHS [5, used with --silver_path]
    inputBinding:
      position: 101
      prefix: -M
  - id: ntcard
    type:
      - 'null'
      - boolean
    doc: Use ntcard to estimate genome size [false, assume max entries]
    inputBinding:
      position: 102
      prefix: --ntcard
  - id: silver_path
    type:
      - 'null'
      - boolean
    doc: Generate silver path(s) instead of golden path. Silver paths terminate 
      when the number of bases recruited equals or exceeds T * r
    inputBinding:
      position: 102
      prefix: --silver_path
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print verbose messages [false]
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: paths
    type:
      type: array
      items: File
    doc: Golden path or silver path sequences written with the output prefix
    outputBinding:
      glob: $(inputs.prefix)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/goldrush:1.2.2--py39h2de1943_0
