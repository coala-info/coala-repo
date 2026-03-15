cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - ReorderSam
label: picard_ReorderSam
doc: Reorders reads in a SAM/BAM/CRAM file to match the contig ordering in a 
  provided reference file, as determined by exact name matching of contigs. 
  Reads mapped to contigs absent in the new reference are unmapped.
inputs:
  - id: input
    type: File
    doc: Input file (SAM/BAM/CRAM) to extract reads from.
    inputBinding:
      position: 101
      prefix: --INPUT
  - id: output
    type: string
    doc: Output file (SAM/BAM/CRAM) to write extracted reads to.
    inputBinding:
      position: 101
      prefix: --OUTPUT
  - id: sequence_dictionary
    type:
      - 'null'
      - File
    doc: A Sequence Dictionary for the OUTPUT file (can be read from one of the 
      following file types (SAM, BAM, CRAM, VCF, BCF, Interval List, Fasta, or 
      Dict)
    inputBinding:
      position: 101
      prefix: --SEQUENCE_DICTIONARY
  - id: allow_contig_length_discordance
    type:
      - 'null'
      - boolean
    doc: If true, then permits mapping from a read contig to a new reference 
      contig with the same name but a different length.
    inputBinding:
      position: 101
      prefix: --ALLOW_CONTIG_LENGTH_DISCORDANCE
  - id: allow_incomplete_dict_concordance
    type:
      - 'null'
      - boolean
    doc: If true, allows only a partial overlap of the original contigs with the
      new reference sequence contigs.
    inputBinding:
      position: 101
      prefix: --ALLOW_INCOMPLETE_DICT_CONCORDANCE
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
    doc: Reference sequence file.
    inputBinding:
      position: 101
      prefix: --REFERENCE_SEQUENCE
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
  - id: output_output
    type: File
    doc: Output file (SAM/BAM/CRAM) to write extracted reads to.
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
s:url: http://broadinstitute.github.io/picard/
$namespaces:
  s: https://schema.org/
