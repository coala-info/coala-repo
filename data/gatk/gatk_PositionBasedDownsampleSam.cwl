cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- PositionBasedDownsampleSam
label: gatk_PositionBasedDownsampleSam
doc: |-
  Summary Class to downsample a SAM/BAM/CRAM file based on the position of the read in a flowcell. As with DownsampleSam, all the reads with the same queryname are either kept or dropped as a unit. Details The downsampling is _not_ random (and there is no random seed). It is deterministically determined by the position of each read within its tile. Specifically, it draws an ellipse that covers a FRACTION of the total tile's area and of all the edges of the tile. It uses this area to determine whether to keep or drop the record. Since reads with the same name have the same position (mates, secondary and supplemental alignments), the decision will be the same for all of them. The main concern of this downsampling method is that due to "optical duplicates" downsampling randomly can create a result that has a different optical duplicate rate, and therefore a different estimated library size (when running MarkDuplicates). This method keeps (physically) close read together, so that (except for reads near the boundary of the circle) optical duplicates are kept or dropped as a group. By default the program expects the read names to have 5 or 7 fields separated by colons (:) and it takes the last two to indicate the x and y coordinates of the reads within the tile whence it was sequenced. See DEFAULT_READ_NAME_REGEX for more detail. The program traverses the INPUT twice: first to find out the size of each of the tiles, and next to perform the downsampling. Downsampling invalidates the duplicate flag because duplicate reads before downsampling may not all remain duplicated after downsampling. Thus, the default setting also removes the duplicate information.

  Tool homepage: https://www.broadinstitute.org/gatk/
inputs:
- id: fraction
  type: float
  doc: The (approximate) fraction of reads to be kept, between 0 and 1.
  inputBinding:
    position: 101
    prefix: --FRACTION
- id: input
  type: File
  secondaryFiles:
  - pattern: .bai
    required: false
  - pattern: ^.bai
    required: false
  doc: The input SAM/BAM/CRAM file to downsample.
  inputBinding:
    position: 101
    prefix: --INPUT
- id: output
  type: string
  doc: The output, downsampled, SAM/BAM/CRAM file.
  inputBinding:
    position: 101
    prefix: --OUTPUT
- id: allow_multiple_downsampling_despite_warnings
  type:
  - 'null'
  - boolean
  doc: Allow downsampling again despite this being a bad idea with possibly unexpected results.
  inputBinding:
    position: 101
    prefix: --ALLOW_MULTIPLE_DOWNSAMPLING_DESPITE_WARNINGS
    valueFrom: '$(self === null ? null : String(self))'
- id: arguments_file
  type:
  - 'null'
  - type: array
    items: File
    inputBinding:
      prefix: --arguments_file
  doc: read one or more arguments files and add them to the command line
  inputBinding:
    position: 101
- id: compression_level
  type:
  - 'null'
  - int
  doc: Compression level for all compressed files created (e.g. BAM and VCF).
  inputBinding:
    position: 101
    prefix: --COMPRESSION_LEVEL
- id: create_index
  type:
  - 'null'
  - boolean
  doc: Whether to create an index when writing VCF or coordinate sorted BAM output.
  inputBinding:
    position: 101
    prefix: --CREATE_INDEX
    valueFrom: '$(self === null ? null : String(self))'
- id: create_md5_file
  type:
  - 'null'
  - boolean
  doc: Whether to create an MD5 digest for any BAM or FASTQ files created.
  inputBinding:
    position: 101
    prefix: --CREATE_MD5_FILE
    valueFrom: '$(self === null ? null : String(self))'
- id: max_records_in_ram
  type:
  - 'null'
  - int
  doc: When writing files that need to be sorted, this will specify the number of records stored in RAM
    before spilling to disk. Increasing this number reduces the number of file handles needed to sort
    the file, and increases the amount of RAM needed.
  inputBinding:
    position: 101
    prefix: --MAX_RECORDS_IN_RAM
- id: quiet
  type:
  - 'null'
  - boolean
  doc: Whether to suppress job-summary info on System.err.
  inputBinding:
    position: 101
    prefix: --QUIET
    valueFrom: '$(self === null ? null : String(self))'
- id: read_name_regex
  type:
  - 'null'
  - string
  doc: 'Use these regular expressions to parse read names in the input SAM file. Read names are parsed
    to extract three variables: tile/region, x coordinate and y coordinate. The x and y coordinates are
    used to determine the downsample decision. Set this option to null to disable optical duplicate detection,
    e.g. for RNA-seq The regular expression should contain three capture groups for the three variables,
    in order. It must match the entire read name. Note that if the default regex is specified, a regex
    match is not actually done, but instead the read name is split on colons (:). For 5 element names,
    the 3rd, 4th and 5th elements are assumed to be tile, x and y values. For 7 element names (CASAVA
    1.8), the 5th, 6th, and 7th elements are assumed to be tile, x and y values.'
  inputBinding:
    position: 101
    prefix: --READ_NAME_REGEX
- id: reference_sequence
  type:
  - 'null'
  - File
  secondaryFiles:
  - .fai
  - ^.dict
  doc: Reference sequence file.
  inputBinding:
    position: 101
    prefix: --REFERENCE_SEQUENCE
- id: remove_duplicate_information
  type:
  - 'null'
  - boolean
  doc: Determines whether the duplicate tag should be reset since the downsampling requires re-marking
    duplicates.
  inputBinding:
    position: 101
    prefix: --REMOVE_DUPLICATE_INFORMATION
    valueFrom: '$(self === null ? null : String(self))'
- id: stop_after
  type:
  - 'null'
  - long
  doc: Stop after processing N reads, mainly for debugging.
  inputBinding:
    position: 101
    prefix: --STOP_AFTER
- id: tmp_dir
  type:
  - 'null'
  - type: array
    items: File
    inputBinding:
      prefix: --TMP_DIR
  doc: One or more directories with space available to be used by this program for temporary storage of
    working files
  inputBinding:
    position: 101
- id: use_jdk_deflater
  type:
  - 'null'
  - boolean
  doc: Use the JDK Deflater instead of the Intel Deflater for writing compressed output
  inputBinding:
    position: 101
    prefix: --USE_JDK_DEFLATER
    valueFrom: '$(self === null ? null : String(self))'
- id: use_jdk_inflater
  type:
  - 'null'
  - boolean
  doc: Use the JDK Inflater instead of the Intel Inflater for reading compressed input
  inputBinding:
    position: 101
    prefix: --USE_JDK_INFLATER
    valueFrom: '$(self === null ? null : String(self))'
- id: validation_stringency
  type:
  - 'null'
  - string
  doc: 'Validation stringency for all SAM files read by this program. Setting stringency to SILENT can
    improve performance when processing a BAM file in which variable-length data (read, qualities, tags)
    do not otherwise need to be decoded. Possible values: {STRICT, LENIENT, SILENT}'
  inputBinding:
    position: 101
    prefix: --VALIDATION_STRINGENCY
- id: verbosity
  type:
  - 'null'
  - string
  doc: 'Control verbosity of logging. Possible values: {ERROR, WARNING, INFO, DEBUG}'
  inputBinding:
    position: 101
    prefix: --VERBOSITY
- id: java_options
  type:
  - 'null'
  - string
  doc: Java options for the GATK launcher, for example -Xmx4g
  inputBinding:
    position: 101
    prefix: --java-options
outputs:
- id: output_output
  type: File
  doc: The output, downsampled, SAM/BAM/CRAM file.
  outputBinding:
    glob: $(inputs.output)
  secondaryFiles:
  - pattern: .bai
    required: false
  - pattern: ^.bai
    required: false
  - pattern: .crai
    required: false
  - pattern: ^.crai
    required: false
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
