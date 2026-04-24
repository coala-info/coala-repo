cwlVersion: v1.2
class: CommandLineTool
baseCommand: mashmap
label: mashmap
doc: "Mashmap is an pproximate long read or contig mapper based on Jaccard similarity\n\
  \nTool homepage: https://github.com/marbl/MashMap"
inputs:
  - id: block_length
    type:
      - 'null'
      - int
    doc: 'keep merged mappings supported by homologies of at least this length [default:
      segmentLength]'
    inputBinding:
      position: 101
      prefix: --blockLength
  - id: chain_gap
    type:
      - 'null'
      - int
    doc: 'chain mappings closer than this distance in query and target, retaining
      mappings in best chain [default: segmentLength]'
    inputBinding:
      position: 101
      prefix: --chainGap
  - id: dense_sketching
    type:
      - 'null'
      - boolean
    doc: Use dense sketching to yield higher ANI estimation accuracy. [disabled 
      by default]
    inputBinding:
      position: 101
      prefix: --dense
  - id: drop_low_map_id
    type:
      - 'null'
      - boolean
    doc: drop mappings with estimated identity below --perc_identity=%
    inputBinding:
      position: 101
      prefix: --dropLowMapId
  - id: filter_length_mismatches
    type:
      - 'null'
      - boolean
    doc: Filter mappings where the ratio of reference/query mapped lengths 
      disagrees with the ANI threshold
    inputBinding:
      position: 101
      prefix: --filterLengthMismatches
  - id: filter_mode
    type:
      - 'null'
      - string
    doc: "filter modes in mashmap: 'map', 'one-to-one' or 'none'. 'map' computes best
      mappings for each query sequence. 'one-to-one' computes best mappings for query
      as well as reference sequence. 'none' disables filtering"
    inputBinding:
      position: 101
      prefix: --filter_mode
  - id: hg_filter_ani_diff
    type:
      - 'null'
      - float
    doc: Filter out mappings unlikely to be this ANI less than the best mapping
    inputBinding:
      position: 101
      prefix: --hgFilterAniDiff
  - id: hg_filter_confidence
    type:
      - 'null'
      - string
    doc: Confidence value for the hypergeometric filtering
    inputBinding:
      position: 101
      prefix: --hgFilterConf
  - id: kmer_complexity
    type:
      - 'null'
      - float
    doc: threshold for kmer complexity [0, 1]
    inputBinding:
      position: 101
      prefix: --kmerComplexity
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: kmer size
    inputBinding:
      position: 101
      prefix: --kmer
  - id: kmer_threshold
    type:
      - 'null'
      - float
    doc: ignore the top % most-frequent kmer window
    inputBinding:
      position: 101
      prefix: --kmerThreshold
  - id: legacy_output
    type:
      - 'null'
      - boolean
    doc: MashMap2 output format
    inputBinding:
      position: 101
      prefix: --legacy
  - id: load_index_prefix
    type:
      - 'null'
      - string
    doc: Prefix of index files to load, where PREFIX.map and PREFIX.index are 
      the files to be loaded
    inputBinding:
      position: 101
      prefix: --loadIndex
  - id: lower_triangular
    type:
      - 'null'
      - boolean
    doc: Only map sequence i to sequence j if i > j.
    inputBinding:
      position: 101
      prefix: --lowerTriangular
  - id: no_hypergeometric_filter
    type:
      - 'null'
      - boolean
    doc: Don't use the hypergeometric filtering and instead use the MashMap2 
      first pass filtering.
    inputBinding:
      position: 101
      prefix: --noHgFilter
  - id: no_merge
    type:
      - 'null'
      - boolean
    doc: don't merge consecutive segment-level mappings
    inputBinding:
      position: 101
      prefix: --noMerge
  - id: no_split
    type:
      - 'null'
      - boolean
    doc: disable splitting of input sequences during mapping [enabled by 
      default]
    inputBinding:
      position: 101
      prefix: --noSplit
  - id: num_mappings_for_segment
    type:
      - 'null'
      - int
    doc: number of mappings to retain for each segment
    inputBinding:
      position: 101
      prefix: --numMappingsForSegment
  - id: num_mappings_for_short_seq
    type:
      - 'null'
      - int
    doc: number of mappings to retain for each sequence shorter than segment 
      length
    inputBinding:
      position: 101
      prefix: --numMappingsForShortSeq
  - id: perc_identity
    type:
      - 'null'
      - float
    doc: threshold for identity
    inputBinding:
      position: 101
      prefix: --perc_identity
  - id: query_file
    type:
      - 'null'
      - File
    doc: an input query file (fasta/fastq)[.gz]
    inputBinding:
      position: 101
      prefix: --query
  - id: query_files_list
    type:
      - 'null'
      - File
    doc: a file containing list of query files, one per line
    inputBinding:
      position: 101
      prefix: --queryList
  - id: reference_file
    type:
      - 'null'
      - File
    doc: an input reference file (fasta/fastq)[.gz]
    inputBinding:
      position: 101
      prefix: --ref
  - id: reference_files_list
    type:
      - 'null'
      - File
    doc: a file containing list of reference files, one per line
    inputBinding:
      position: 101
      prefix: --refList
  - id: report_percentage
    type:
      - 'null'
      - boolean
    doc: Report predicted ANI values in [0, 100] instead of [0,1] (necessary for
      use with wfmash)
    inputBinding:
      position: 101
      prefix: --reportPercentage
  - id: save_index_prefix
    type:
      - 'null'
      - string
    doc: Prefix of index files to save. PREFIX.map and PREFIX.index files will 
      be created
    inputBinding:
      position: 101
      prefix: --saveIndex
  - id: segment_length
    type:
      - 'null'
      - int
    doc: mapping segment length. sequences shorter than segment length will be 
      ignored
    inputBinding:
      position: 101
      prefix: --segLength
  - id: sketch_size
    type:
      - 'null'
      - int
    doc: Number of sketch elements
    inputBinding:
      position: 101
      prefix: --sketchSize
  - id: skip_prefix
    type:
      - 'null'
      - string
    doc: skip mappings when the query and target have the same prefix before the
      last occurrence of the given character C
    inputBinding:
      position: 101
      prefix: --skipPrefix
  - id: skip_self
    type:
      - 'null'
      - boolean
    doc: skip self mappings when the query and target name is the same (for 
      all-vs-all mode)
    inputBinding:
      position: 101
      prefix: --skipSelf
  - id: sparsify_mappings
    type:
      - 'null'
      - float
    doc: keep this fraction of mappings
    inputBinding:
      position: 101
      prefix: --sparsifyMappings
  - id: target_list
    type:
      - 'null'
      - File
    doc: file containing list of target sequence names
    inputBinding:
      position: 101
      prefix: --targetList
  - id: target_prefix
    type:
      - 'null'
      - string
    doc: Only index reference sequences beginning with this prefix
    inputBinding:
      position: 101
      prefix: --targetPrefix
  - id: threads
    type:
      - 'null'
      - int
    doc: count of threads for parallel execution
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mashmap:3.1.3--pl5321hb4818e0_2
