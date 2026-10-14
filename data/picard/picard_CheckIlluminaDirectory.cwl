cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - CheckIlluminaDirectory
label: picard_CheckIlluminaDirectory
doc: Asserts the validity for specified Illumina basecalling data. This tool 
  will check that the basecall directory and the internal files are available, 
  exist, and are reasonably sized for every tile and cycle.
inputs:
  - id: intensities_dir
    type: Directory
    doc: The Data/Intensities directory of the Illumina run folder. It holds the
      BaseCalls directory, the lane position files (L001/*.clocs or s.locs) and
      the filter files. It is staged as run/Data/Intensities and BASECALLS_DIR 
      is set to run/Data/Intensities/BaseCalls, so that Picard finds the files 
      it reads from the parent of BaseCalls.
    inputBinding:
      position: 101
      prefix: --BASECALLS_DIR
      valueFrom: run/Data/Intensities/BaseCalls
  - id: interop_dir
    type:
      - 'null'
      - Directory
    doc: The InterOp directory of the Illumina run folder (it holds 
      TileMetricsOut.bin, which Picard reads to get the expected tiles). It is 
      staged as run/InterOp.
  - id: lanes
    type:
      type: array
      items: int
      inputBinding:
        prefix: --LANES
    doc: The number of the lane(s) to check. This argument must be specified at 
      least once.
    inputBinding:
      position: 101
  - id: read_structure
    type: string
    doc: A description of the logical structure of clusters in an Illumina Run, 
      i.e. a description of the structure IlluminaBasecallsToSam assumes the 
      data to be in.
    inputBinding:
      position: 101
      prefix: --READ_STRUCTURE
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
    doc: Whether to create an index when writing VCF or coordinate sorted BAM 
      output.
    inputBinding:
      position: 101
      prefix: --CREATE_INDEX
  - id: create_md5_file
    type:
      - 'null'
      - boolean
    doc: Whether to create an MD5 digest for any BAM or FASTQ files created.
    inputBinding:
      position: 101
      prefix: --CREATE_MD5_FILE
  - id: data_types
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --DATA_TYPES
    doc: 'The data types that should be checked for each tile/cycle. Possible values:
      {Position, BaseCalls, QualityScores, PF, Barcodes}'
    inputBinding:
      position: 101
  - id: fake_files
    type:
      - 'null'
      - boolean
    doc: A flag to determine whether or not to create fake versions of the 
      missing files.
    inputBinding:
      position: 101
      prefix: --FAKE_FILES
  - id: link_locs
    type:
      - 'null'
      - boolean
    doc: A flag to create symlinks to the loc file for the X Ten for each tile. 
      @deprecated It is no longer necessary to create locs file symlinks.
    inputBinding:
      position: 101
      prefix: --LINK_LOCS
  - id: max_records_in_ram
    type:
      - 'null'
      - int
    doc: When writing files that need to be sorted, this will specify the number
      of records stored in RAM before spilling to disk.
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
  - id: reference_sequence
    type:
      - 'null'
      - File
    secondaryFiles:
      - .fai
    doc: Reference sequence file.
    inputBinding:
      position: 101
      prefix: --REFERENCE_SEQUENCE
  - id: tile_numbers
    type:
      - 'null'
      - type: array
        items: int
        inputBinding:
          prefix: --TILE_NUMBERS
    doc: The number(s) of the tile(s) to check.
    inputBinding:
      position: 101
  - id: tmp_dir
    type:
      - 'null'
      - type: array
        items: Directory
        inputBinding:
          prefix: --TMP_DIR
    doc: One or more directories with space available to be used by this program
      for temporary storage of working files
    inputBinding:
      position: 101
  - id: use_jdk_deflater
    type:
      - 'null'
      - boolean
    doc: Use the JDK Deflater instead of the Intel Deflater for writing 
      compressed output
    inputBinding:
      position: 101
      prefix: --USE_JDK_DEFLATER
  - id: use_jdk_inflater
    type:
      - 'null'
      - boolean
    doc: Use the JDK Inflater instead of the Intel Inflater for reading 
      compressed input
    inputBinding:
      position: 101
      prefix: --USE_JDK_INFLATER
  - id: validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for all SAM files read by this program. Possible values:
      {STRICT, LENIENT, SILENT}'
    inputBinding:
      position: 101
      prefix: --VALIDATION_STRINGENCY
  - id: show_hidden
    type:
      - 'null'
      - boolean
    doc: display hidden arguments
    inputBinding:
      position: 101
      prefix: --showHidden
outputs:
  - id: stderr
    type: stderr
    doc: Standard error; holds the Picard log with the check result.
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entryname: run/Data/Intensities
        entry: $(inputs.intensities_dir)
        writable: true
      - entryname: run/InterOp
        entry: $(inputs.interop_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
stderr: picard_CheckIlluminaDirectory.err
s:url: http://broadinstitute.github.io/picard/
$namespaces:
  s: https://schema.org/
