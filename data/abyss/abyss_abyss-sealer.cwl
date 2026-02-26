cwlVersion: v1.2
class: CommandLineTool
baseCommand: abyss-sealer-b
label: abyss_abyss-sealer
doc: "Close gaps by using left and right flanking sequences of gaps as 'reads' for
  Konnector and performing multiple runs with each of the supplied K values.\n\nTool
  homepage: https://www.bcgsc.ca/platform/bioinfo/software/abyss"
inputs:
  - id: reads1
    type: File
    doc: First set of reads
    inputBinding:
      position: 1
  - id: reads2
    type:
      - 'null'
      - type: array
        items: File
    doc: Additional read files
    inputBinding:
      position: 2
  - id: bloom_size
    type:
      - 'null'
      - string
    doc: size of Bloom filter (e.g. '40G'). Required when not using pre-built 
      Bloom filter(s) (-i option)
    inputBinding:
      position: 103
      prefix: --bloom-size
  - id: chastity
    type:
      - 'null'
      - boolean
    doc: discard unchaste reads [default]
    inputBinding:
      position: 103
      prefix: --chastity
  - id: fix_errors
    type:
      - 'null'
      - boolean
    doc: find and fix single-base errors when reads have no kmers in bloom 
      filter
    inputBinding:
      position: 103
      prefix: --fix-errors
  - id: flank_length
    type:
      - 'null'
      - int
    doc: length of flanks to be used as pseudoreads
    default: 100
    inputBinding:
      position: 103
      prefix: --flank-length
  - id: flank_mismatches
    type:
      - 'null'
      - string
    doc: max mismatches between paths and flanks
    default: nolimit
    inputBinding:
      position: 103
      prefix: --flank-mismatches
  - id: illumina_quality
    type:
      - 'null'
      - boolean
    doc: zero quality is `@' (64) default for qseq and export files
    inputBinding:
      position: 103
      prefix: --illumina-quality
  - id: input_bloom
    type:
      - 'null'
      - File
    doc: load bloom filter from FILE
    inputBinding:
      position: 103
      prefix: --input-bloom
  - id: input_scaffold
    type: File
    doc: load scaffold from FILE
    inputBinding:
      position: 103
      prefix: --input-scaffold
  - id: kmer
    type:
      type: array
      items: int
    doc: the size of a k-mer
    inputBinding:
      position: 103
      prefix: --kmer
  - id: lower
    type:
      - 'null'
      - boolean
    doc: seal sequences with lower-case IUPAC characters
    inputBinding:
      position: 103
      prefix: --lower
  - id: mask
    type:
      - 'null'
      - boolean
    doc: mask new and changed bases as lower case
    inputBinding:
      position: 103
      prefix: --mask
  - id: max_branches
    type:
      - 'null'
      - string
    doc: 'Deprecated: max branches in de Bruijn graph traversal'
    default: nolimit
    inputBinding:
      position: 103
      prefix: --max-branches
  - id: max_cost
    type:
      - 'null'
      - int
    doc: max edges to traverse during each graph search
    default: 100000
    inputBinding:
      position: 103
      prefix: --max-cost
  - id: max_frag
    type:
      - 'null'
      - int
    doc: 'Deprecated: max fragment size in base pairs'
    inputBinding:
      position: 103
      prefix: --max-frag
  - id: max_gap_length
    type:
      - 'null'
      - int
    doc: max gap size to fill in bp
    default: 800
    inputBinding:
      position: 103
      prefix: --max-gap-length
  - id: max_mismatches
    type:
      - 'null'
      - string
    doc: max mismatches between all alternate paths
    default: nolimit
    inputBinding:
      position: 103
      prefix: --max-mismatches
  - id: max_paths
    type:
      - 'null'
      - int
    doc: merge at most N alternate paths
    default: 2
    inputBinding:
      position: 103
      prefix: --max-paths
  - id: min_frag
    type:
      - 'null'
      - int
    doc: 'Deprecated: min fragment size in base pairs'
    inputBinding:
      position: 103
      prefix: --min-frag
  - id: no_chastity
    type:
      - 'null'
      - boolean
    doc: do not discard unchaste reads
    inputBinding:
      position: 103
      prefix: --no-chastity
  - id: no_limits
    type:
      - 'null'
      - boolean
    doc: disable all limits; equivalent to '-B nolimit -m nolimit -M nolimit -P 
      nolimit'
    inputBinding:
      position: 103
      prefix: --no-limits
  - id: no_mask
    type:
      - 'null'
      - boolean
    doc: do not mask bases [default]
    inputBinding:
      position: 103
      prefix: --no-mask
  - id: no_trim_masked
    type:
      - 'null'
      - boolean
    doc: do not trim masked bases from the ends of reads [default]
    inputBinding:
      position: 103
      prefix: --no-trim-masked
  - id: print_flanks
    type:
      - 'null'
      - boolean
    doc: outputs flank files
    inputBinding:
      position: 103
      prefix: --print-flanks
  - id: read_name
    type:
      - 'null'
      - string
    doc: only process reads with names that contain STR
    inputBinding:
      position: 103
      prefix: --read-name
  - id: search_mem
    type:
      - 'null'
      - string
    doc: mem limit for graph searches
    default: 500M
    inputBinding:
      position: 103
      prefix: --search-mem
  - id: standard_quality
    type:
      - 'null'
      - boolean
    doc: zero quality is `!' (33) default for FASTQ and SAM files
    inputBinding:
      position: 103
      prefix: --standard-quality
  - id: threads
    type:
      - 'null'
      - int
    doc: use N parallel threads
    default: 1
    inputBinding:
      position: 103
      prefix: --threads
  - id: trim_masked
    type:
      - 'null'
      - boolean
    doc: trim masked bases from the ends of reads
    inputBinding:
      position: 103
      prefix: --trim-masked
  - id: trim_quality
    type:
      - 'null'
      - int
    doc: trim bases from the ends of reads whose quality is less than the 
      threshold
    inputBinding:
      position: 103
      prefix: --trim-quality
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: display verbose output
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: dot_file
    type:
      - 'null'
      - File
    doc: write graph traversals to a DOT file
    outputBinding:
      glob: $(inputs.dot_file)
  - id: output_prefix
    type: File
    doc: prefix of output FASTA files
    outputBinding:
      glob: $(inputs.output_prefix)
  - id: gap_file
    type:
      - 'null'
      - File
    doc: write sealed gaps to FILE
    outputBinding:
      glob: $(inputs.gap_file)
  - id: trace_file
    type:
      - 'null'
      - File
    doc: write graph search stats to FILE
    outputBinding:
      glob: $(inputs.trace_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/abyss:2.3.10--hf316886_2
