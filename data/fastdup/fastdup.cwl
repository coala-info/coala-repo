cwlVersion: v1.2
class: CommandLineTool
baseCommand: FastDup
label: fastdup
doc: "Identifies duplicate reads. This tool locates and tags duplicate reads in a
  coordinate ordered SAM or BAM file.\nUse the same algorithm as picard MarkDuplicates
  and output identical results.\nUse spdlog as log tool and the default level is 'info'.\n\
  \nTool homepage: https://github.com/zzhofict/FastDup"
inputs:
  - id: create_index
    type:
      - 'null'
      - boolean
    doc: Whether to create an index when writing coordinate sorted BAM output.
    inputBinding:
      position: 101
      prefix: --create-index
  - id: duplicate_scoring_strategy
    type:
      - 'null'
      - string
    doc: 'The scoring strategy for choosing the non-duplicate among candidates. Possible
      values: {SUM_OF_BASE_QUALITIES, TOTAL_MAPPED_REFERENCE_LENGTH, RANDOM}'
    inputBinding:
      position: 101
      prefix: --duplicate-scoring-strategy
  - id: index_format
    type:
      - 'null'
      - string
    doc: 'Format for bam index file. Possible values: {BAI, CSI}'
    inputBinding:
      position: 101
      prefix: --index-format
  - id: input
    type: File
    doc: Input file. One coordinate ordered SAM or BAM file.
    inputBinding:
      position: 101
      prefix: --input
  - id: metrics
    type: File
    doc: Metrics file. File to write duplication metrics to.
    inputBinding:
      position: 101
      prefix: --metrics
  - id: none_duplex_io
    type:
      - 'null'
      - boolean
    doc: Do not use writing-while-reading mode.
    inputBinding:
      position: 101
      prefix: --none-duplex-io
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 101
      prefix: --num-threads
  - id: optical_duplicate_pixel_distance
    type:
      - 'null'
      - int
    doc: The maximum offset between two duplicate clusters in order to consider 
      them opticalduplicates. The default is appropriate for unpatterned 
      versions of the Illumina platform.For the patterned flowcell models, 2500 
      is moreappropriate. For other platforms andmodels, users should experiment
      to find what works best.
    inputBinding:
      position: 101
      prefix: --optical-duplicate-pixel-distance
  - id: read_name_regex
    type:
      - 'null'
      - string
    doc: "MarkDuplicates can use the tile and cluster positions to estimate the rate
      of optical duplication in addition to the dominant source of duplication, PCR,
      to provide a more accurate estimation of library size. By default (with no READ_NAME_REGEX
      specified), MarkDuplicates will attempt to extract coordinates using a split
      on ':' (see Note below). Set READ_NAME_REGEX to 'null' to disable optical duplicate
      detection. Note that without optical duplicate counts, library size estimation
      will be less accurate. If the read name does not follow a standard Illumina
      colon-separation convention, but does contain tile and x,y coordinates, a regular
      expression can be specified to extract three variables: tile/region, x coordinate
      and y coordinate from a read name. The regular expression must contain three
      capture groups for the three variables, in order. It must match the entire read
      name.   e.g. if field names were separated by semi-colon (';') this example
      regex could be specified      (?:.*;)?([0-9]+)[^;]*;([0-9]+)[^;]*;([0-9]+)[^;]*$
      Note that if no READ_NAME_REGEX is specified, the read name is split on ':'.\
      \   For 5 element names, the 3rd, 4th and 5th elements are assumed to be tile,
      x and y values.   For 7 element names (CASAVA 1.8), the 5th, 6th, and 7th elements
      are assumed to be tile, x and y values. Default value: <optimized capture of
      last three ':' separated fields as numeric values>."
    inputBinding:
      position: 101
      prefix: --read-name-regex
  - id: remove_duplicates
    type:
      - 'null'
      - boolean
    doc: If true do not write duplicates to the output file instead of writing 
      them with appropriate flags set.
    inputBinding:
      position: 101
      prefix: --remove-duplicates
  - id: tag_duplicate_set_members
    type:
      - 'null'
      - boolean
    doc: If a read appears in a duplicate set, add two tags. The first tag, 
      DUPLICATE_SET_SIZE_TAG(DS), indicates the size of the duplicate set. The 
      smallest possible DS value is 2 whichoccurs when two reads map to the same
      portion of the reference only one of which is markedas duplicate. The 
      second tag, DUPLICATE_SET_INDEX_TAG (DI), represents a unique 
      identifierfor the duplicate set to which the record belongs. This 
      identifier is the index-in-file ofthe representative read that was 
      selected out of the duplicate set.
    inputBinding:
      position: 101
      prefix: --tag-duplicate-set-members
  - id: tagging_policy
    type:
      - 'null'
      - string
    doc: 'Determines how duplicate types are recorded in the DT optional attribute.
      Possible values: {DontTag, OpticalOnly, All}.'
    inputBinding:
      position: 101
      prefix: --tagging-policy
outputs:
  - id: output
    type: File
    doc: Output file. SAM or BAM file to write marked records to.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastdup:1.0.0--hc033996_0
