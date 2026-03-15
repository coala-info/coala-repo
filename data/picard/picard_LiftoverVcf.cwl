cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - LiftoverVcf
label: picard_LiftoverVcf
doc: Lifts over a VCF file from one reference build to another, producing a 
  properly headered, sorted and indexed VCF in one go.
inputs:
  - id: chain
    type: File
    doc: The liftover chain file. See 
      https://genome.ucsc.edu/goldenPath/help/chain.html for a description of 
      chain files.
    inputBinding:
      position: 101
      prefix: --CHAIN
  - id: input
    type:
      - 'null'
      - File
    doc: The input VCF/BCF file to be lifted over.
    inputBinding:
      position: 101
      prefix: --INPUT
  - id: output
    type: string
    doc: The output location for the lifted over VCF/BCF.
    inputBinding:
      position: 101
      prefix: --OUTPUT
  - id: reference_sequence
    type:
      - 'null'
      - File
    doc: The reference sequence (fasta) for the TARGET genome build (i.e., the 
      new one. The fasta file must have an accompanying sequence dictionary 
      (.dict file).
    inputBinding:
      position: 101
      prefix: --REFERENCE_SEQUENCE
  - id: reject
    type: string
    doc: File to which to write rejected records.
    inputBinding:
      position: 101
      prefix: --REJECT
  - id: allow_missing_fields_in_header
    type:
      - 'null'
      - boolean
    doc: Allow INFO and FORMAT in the records that are not found in the header
    inputBinding:
      position: 101
      prefix: --ALLOW_MISSING_FIELDS_IN_HEADER
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
  - id: disable_sort
    type:
      - 'null'
      - boolean
    doc: Output VCF file will be written on the fly but it won't be sorted and 
      indexed.
    inputBinding:
      position: 101
      prefix: --DISABLE_SORT
  - id: liftover_min_match
    type:
      - 'null'
      - float
    doc: The minimum percent match required for a variant to be lifted.
    inputBinding:
      position: 101
      prefix: --LIFTOVER_MIN_MATCH
  - id: log_failed_intervals
    type:
      - 'null'
      - boolean
    doc: If true, intervals failing due to match below LIFTOVER_MIN_MATCH will 
      be logged as a warning to the console.
    inputBinding:
      position: 101
      prefix: --LOG_FAILED_INTERVALS
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
  - id: recover_swapped_ref_alt
    type:
      - 'null'
      - boolean
    doc: If the REF allele of the lifted site does not match the target genome, 
      that variant is normally rejected. For bi-allelic SNPs, if this is set to 
      true and the ALT allele equals the new REF allele, the REF and ALT alleles
      will be swapped.
    inputBinding:
      position: 101
      prefix: --RECOVER_SWAPPED_REF_ALT
  - id: tags_to_drop
    type:
      - 'null'
      - type: array
        items: string
    doc: INFO field annotations that should be deleted when swapping reference 
      with variant alleles.
    inputBinding:
      position: 101
      prefix: --TAGS_TO_DROP
  - id: tags_to_reverse
    type:
      - 'null'
      - type: array
        items: string
    doc: INFO field annotations that behave like an Allele Frequency and should 
      be transformed with x->1-x when swapping reference with variant alleles.
    inputBinding:
      position: 101
      prefix: --TAGS_TO_REVERSE
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
  - id: warn_on_missing_contig
    type:
      - 'null'
      - boolean
    doc: Warn on missing contig.
    inputBinding:
      position: 101
      prefix: --WARN_ON_MISSING_CONTIG
  - id: write_original_alleles
    type:
      - 'null'
      - boolean
    doc: Write the original alleles for lifted variants to the INFO field.
    inputBinding:
      position: 101
      prefix: --WRITE_ORIGINAL_ALLELES
  - id: write_original_position
    type:
      - 'null'
      - boolean
    doc: Write the original contig/position for lifted variants to the INFO 
      field.
    inputBinding:
      position: 101
      prefix: --WRITE_ORIGINAL_POSITION
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
    doc: The output location for the lifted over VCF/BCF.
    outputBinding:
      glob: $(inputs.output)
  - id: output_reject
    type: File
    doc: File to which to write rejected records.
    outputBinding:
      glob: $(inputs.reject)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
s:url: http://broadinstitute.github.io/picard/
$namespaces:
  s: https://schema.org/
