cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - SplitVcfs
label: picard_SplitVcfs
doc: Splits SNPs and INDELs into separate files. This tool reads in a VCF or BCF
  file and writes out the SNPs and INDELs it contains to separate files. The 
  headers of the two output files will be identical and index files will be 
  created for both outputs. If records other than SNPs or INDELs are present, 
  set the STRICT option to "false", otherwise the tool will raise an exception 
  and quit.
inputs:
  - id: indel_output
    type: string
    doc: The VCF or BCF file to which indel records should be written. The file 
      format is determined by file extension.
    inputBinding:
      position: 101
      prefix: --INDEL_OUTPUT
  - id: input
    type:
      - 'null'
      - File
    doc: The VCF or BCF input file
    inputBinding:
      position: 101
      prefix: --INPUT
  - id: snp_output
    type: string
    doc: The VCF or BCF file to which SNP records should be written. The file 
      format is determined by file extension.
    inputBinding:
      position: 101
      prefix: --SNP_OUTPUT
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: read one or more arguments files and add them to the command line
    inputBinding:
      position: 101
      prefix: --arguments_file
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
  - id: max_records_in_ram
    type:
      - 'null'
      - int
    doc: When writing files that need to be sorted, this will specify the number
      of records stored in RAM before spilling to disk. Increasing this number 
      reduces the number of file handles needed to sort the file, and increases 
      the amount of RAM needed.
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
    doc: Reference sequence file.
    inputBinding:
      position: 101
      prefix: --REFERENCE_SEQUENCE
  - id: sequence_dictionary
    type:
      - 'null'
      - File
    doc: The index sequence dictionary to use instead of the sequence 
      dictionaries in the input files
    inputBinding:
      position: 101
      prefix: --SEQUENCE_DICTIONARY
  - id: strict
    type:
      - 'null'
      - boolean
    doc: If true an exception will be thrown if an event type other than SNP or 
      indel is encountered
    inputBinding:
      position: 101
      prefix: --STRICT
  - id: tmp_dir
    type:
      - 'null'
      - type: array
        items: Directory
    doc: One or more directories with space available to be used by this program
      for temporary storage of working files
    inputBinding:
      position: 101
      prefix: --TMP_DIR
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
    doc: Validation stringency for all SAM files read by this program. Setting 
      stringency to SILENT can improve performance when processing a BAM file in
      which variable-length data (read, qualities, tags) do not otherwise need 
      to be decoded.
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
  - id: output_indel_output
    type: File
    doc: The VCF or BCF file to which indel records should be written. The file 
      format is determined by file extension.
    outputBinding:
      glob: $(inputs.indel_output)
  - id: output_snp_output
    type: File
    doc: The VCF or BCF file to which SNP records should be written. The file 
      format is determined by file extension.
    outputBinding:
      glob: $(inputs.snp_output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
s:url: http://broadinstitute.github.io/picard/
$namespaces:
  s: https://schema.org/
