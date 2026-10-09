cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - je
  - markdupes
label: je-suite_markdupes
doc: "Examines aligned records in the supplied SAM or BAM file to locate duplicate molecules, taking into\
  \ account molecular barcodes (UMIs) found in the read name.\n\nTool homepage: https://gbcs.embl.de/Je"
inputs:
  - id: input
    type:
      type: array
      items: File
      inputBinding:
        prefix: INPUT=
        separate: false
    doc: One or more input SAM or BAM files to analyze. Must be coordinate sorted.
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: The output file to write marked records to
    inputBinding:
      position: 2
      prefix: OUTPUT=
      separate: false
  - id: mismatches
    type: int
    doc: Number of MisMatches (inclusive) to still consider two Unique Molecular Identifiers (UMIs) identical
      i.e. this option buffers for sequencing errors.Indeed, in case of a sequencing error, 2 duplicate
      reads would not be considered duplicates anymore.Note that N are not considered mismatches during
      comparison ie ATTNGG and NTTANG are seen as the same barcode and these two reads would be flagged
      duplicates.This option takes a single value even when several barcodes are present (see SLOTS).
      Note that when declaring several barcodes (see SLOTS) AND providing a predefined set of barcodes
      (see BC option), the MM value is applicable in each lookup. When a predefined set of barcodes is
      NOT given, the different barcodes (SLOTS) are concatenated first and the MM value is therefore considered
      *overall* as the concatenated code is seen as a unique code. MM=null is like MM=0 Use the minimum
      Hamming distance of the original barcode set (if applicable).
    inputBinding:
      position: 3
      prefix: MISMATCHES=
      separate: false
  - id: max_number_of_n
    type:
      - 'null'
      - int
    doc: 'Maximum number of Ns a molecular code can contain (inclusive). Above this value, reads are placed
      in a UNDEF group.More precisely, these ''too degenarate'' codes will not : * be compared to the
      list of predefined codes [predefined code list situation ie BC option given] nor * be considered
      as a potential independent code [no predefined code list situation ie BC option not given] Default
      value is the MISMATCHES number. Note that when declaring several barcodes (see SLOTS) AND providing
      a predefined set of barcodes (see BC option), the MAX_N value is applicable to each barcode. When
      a predefined set of barcodes is NOT given, the different barcodes (SLOTS) are concatenated first
      and the MAX_N value is therefore considered *overall*.'
    inputBinding:
      position: 4
      prefix: MAX_NUMBER_OF_N=
      separate: false
  - id: slots
    type:
      - 'null'
      - type: array
        items: int
        inputBinding:
          prefix: SLOTS=
          separate: false
    doc: 'Where to find the UMIs (and only the UMIs) in the read name once read name has been tokenized
      using the SPLIT character (e.g. '':''). By default, the UMI is considered to be found at the end
      of the read header i.e. after the last '':''. Use this option to indicate other or additional UMI
      positions (e.g. multiple UMIs present in read header. IMPORTANT : counting starts at 1 and negative
      numbers can be used to start counting from the end. For example, consider the following read name
      that lists 3 different barcodes in the end : HISEQ:44:C6KC0ANXX:8:2112:20670:79594:CGATGTTT:GATCCTAG:AAGGTACG
      to indicate that the three barcodes are molecular codes, use SLOTS=-1 SLOTS=-2 SLOTS=-3 if only
      the 2 last ones should be considered (the third one being a sample encoding barcode), use SLOTS=-1
      SLOTS=-2 N.B.: UMI usage can be deactivate by explicitely setting SLOTS=null in the command line'
    inputBinding:
      position: 5
  - id: barcode_file
    type:
      - 'null'
      - File
    doc: 'Pre-defined list of UMIs that can be expected. Format: one column text file, one barcode per
      line. All UMIs MUST have the same length.'
    inputBinding:
      position: 6
      prefix: BARCODE_FILE=
      separate: false
  - id: metrics_file
    type: string
    doc: File to write duplication metrics to
    inputBinding:
      position: 7
      prefix: METRICS_FILE=
      separate: false
  - id: remove_duplicates
    type:
      - 'null'
      - boolean
    doc: 'If true do not write duplicates to the output file instead of writing them with appropriate
      flags set. Possible values: {true, false}'
    inputBinding:
      position: 8
      valueFrom: ${ if (self === null || self === undefined) { return null; } return "REMOVE_DUPLICATES="
        + self; }
  - id: assume_sorted
    type:
      - 'null'
      - boolean
    doc: 'If true, assume that the input file is coordinate sorted even if the header says otherwise.
      Deprecated, used ASSUME_SORT_ORDER=coordinate instead. Possible values: {true, false} Cannot be
      used in conjuction with option(s) ASSUME_SORT_ORDER (ASO)'
    inputBinding:
      position: 9
      valueFrom: ${ if (self === null || self === undefined) { return null; } return "ASSUME_SORTED="
        + self; }
  - id: trim_headers
    type:
      - 'null'
      - boolean
    doc: 'Should barcode information be removed from read names in the output BAM ? This is usefull to
      save storage space. Possible values: {true, false}'
    inputBinding:
      position: 10
      valueFrom: ${ if (self === null || self === undefined) { return null; } return "TRIM_HEADERS=" +
        self; }
  - id: tslots
    type:
      - 'null'
      - type: array
        items: int
        inputBinding:
          prefix: TSLOTS=
          separate: false
    doc: 'Where to find *all* barcode(s) (i.e. sample encoding and UMIs) in the read name once has been
      tokenized using the SPLIT character (e.g. '':''). This option is only considered when TRIM_HEADERS=true.
      When TSLOTS is ommited while TRIM_HEADERS=true, the values of SLOTS apply. IMPORTANT : counting
      starts at 1 and negative numbers can be used to start counting from the end. See SLOT help for examples.'
    inputBinding:
      position: 11
  - id: split_char
    type:
      - 'null'
      - string
    doc: Character to use to split up the read header line, default is ':'.
    inputBinding:
      position: 12
      prefix: SPLIT_CHAR=
      separate: false
  - id: assume_sort_order
    type:
      - 'null'
      - string
    doc: 'If not null, assume that the input file has this order even if the header says otherwise.Possible
      values: {unsorted, queryname, coordinate, duplicate, unknown} Cannot be used in conjuction with
      option(s) ASSUME_SORTED (AS)'
    inputBinding:
      position: 13
      prefix: ASSUME_SORT_ORDER=
      separate: false
  - id: duplicate_scoring_strategy
    type:
      - 'null'
      - string
    doc: 'The scoring strategy for choosing the non-duplicate among candidates. Possible values: {SUM_OF_BASE_QUALITIES,
      TOTAL_MAPPED_REFERENCE_LENGTH, RANDOM}'
    inputBinding:
      position: 14
      prefix: DUPLICATE_SCORING_STRATEGY=
      separate: false
  - id: program_record_id
    type:
      - 'null'
      - string
    doc: The program record ID for the @PG record(s) created by this program. Set to null to disable PG
      record creation. This string may have a suffix appended to avoid collision with other program record
      IDs.
    inputBinding:
      position: 15
      prefix: PROGRAM_RECORD_ID=
      separate: false
  - id: program_group_version
    type:
      - 'null'
      - string
    doc: Value of VN tag of PG record to be created. If not specified, the version will be detected automatically.
    inputBinding:
      position: 16
      prefix: PROGRAM_GROUP_VERSION=
      separate: false
  - id: program_group_command_line
    type:
      - 'null'
      - string
    doc: Value of CL tag of PG record to be created. If not supplied the command line will be detected
      automatically.
    inputBinding:
      position: 17
      prefix: PROGRAM_GROUP_COMMAND_LINE=
      separate: false
  - id: program_group_name
    type:
      - 'null'
      - string
    doc: Value of PN tag of PG record to be created.
    inputBinding:
      position: 18
      prefix: PROGRAM_GROUP_NAME=
      separate: false
  - id: comment
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: COMMENT=
          separate: false
    doc: Comment(s) to include in the output file's header.
    inputBinding:
      position: 19
  - id: read_name_regex
    type:
      - 'null'
      - string
    doc: 'Regular expression that can be used to parse read names in the incoming SAM file. Read names
      are parsed to extract three variables: tile/region, x coordinate and y coordinate. These values
      are used to estimate the rate of optical duplication in order to give a more accurate estimated
      library size. Set this option to null to disable optical duplicate detection, e.g. for RNA-seq or
      other data where duplicate sets are extremely large and estimating library complexity is not an
      aim. Note that without optical duplicate counts, library size estimation will be inaccurate. The
      regular expression should contain three capture groups for the three variables, in order. It must
      match the entire read name. Note that if the default regex is specified, a regex match is not actually
      done, but instead the read name is split on colon character. For 5 element names, the 3rd, 4th and
      5th elements are assumed to be tile, x and y values. For 7 element names (CASAVA 1.8), the 5th,
      6th, and 7th elements are assumed to be tile, x and y values.'
    inputBinding:
      position: 20
      prefix: READ_NAME_REGEX=
      separate: false
  - id: optical_duplicate_pixel_distance
    type:
      - 'null'
      - int
    doc: The maximum offset between two duplicate clusters in order to consider them optical duplicates.
      The default is appropriate for unpatterned versions of the Illumina platform. For the patterned
      flowcell models, 2500 is moreappropriate. For other platforms and models, users should experiment
      to find what works best.
    inputBinding:
      position: 21
      prefix: OPTICAL_DUPLICATE_PIXEL_DISTANCE=
      separate: false
  - id: max_file_handles_for_read_ends_map
    type:
      - 'null'
      - int
    doc: Maximum number of file handles to keep open when spilling read ends to disk. Set this number
      a little lower than the per-process maximum number of file that may be open. This number can be
      found by executing the 'ulimit -n' command on a Unix system.
    inputBinding:
      position: 22
      prefix: MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=
      separate: false
  - id: sorting_collection_size_ratio
    type:
      - 'null'
      - double
    doc: 'This number, plus the maximum RAM available to the JVM, determine the memory footprint used
      by some of the sorting collections. If you are running out of memory, try reducing this number.[help]
      je markdupes: ok via je markdupes --help (--help=ok, -h=ok, -help=ok, (no args)=ok)'
    inputBinding:
      position: 23
      prefix: SORTING_COLLECTION_SIZE_RATIO=
      separate: false
outputs:
  - id: output_file
    type: File
    doc: Output file written to the path given in output
    outputBinding:
      glob: $(inputs.output)
  - id: metrics_file_file
    type: File
    doc: Output file written to the path given in metrics_file
    outputBinding:
      glob: $(inputs.metrics_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/je-suite:2.0.RC--0
