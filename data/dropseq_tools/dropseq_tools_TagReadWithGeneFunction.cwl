cwlVersion: v1.2
class: CommandLineTool
baseCommand: TagReadWithGeneFunction
label: dropseq_tools_TagReadWithGeneFunction
doc: "Tags reads that are exonic for the gene name of the overlapping exon. This is
  done specifically to solve the case where a read may be tagged with a gene and an
  exon, but the read may not be exonic for all genes tagged. This limits the list
  of genes to only those where the read overlaps the exon and the gene.Reads that
  overlap multiple genes are assigned to the gene that shares the strand with the
  read. If that assignment is ambiguous (2 or more genes share the strand of the read),
  then the read is not assigned any genes.\n\nTool homepage: http://mccarrolllab.com/dropseq/"
inputs:
  - id: annotations_file
    type: File
    doc: The annotations set to use to label the read. This can be a GTF or a 
      refFlat file.
    inputBinding:
      position: 101
      prefix: --ANNOTATIONS_FILE
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
      - string
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
  - id: echo_command
    type:
      - 'null'
      - boolean
    doc: Echo final command line before executing.
    inputBinding:
      position: 101
      prefix: -v
  - id: gene_function_tag
    type:
      - 'null'
      - string
    doc: "Gene Function tag. For a given gene name <GENE_NAME_TAG>, this is the function
      of the gene at this read's position: UTR/CODING/INTRONIC/..."
    inputBinding:
      position: 101
      prefix: --GENE_FUNCTION_TAG
  - id: gene_name_tag
    type:
      - 'null'
      - string
    doc: Gene Name tag. Takes on the gene name this read overlaps (if any)
    inputBinding:
      position: 101
      prefix: --GENE_NAME_TAG
  - id: gene_strand_tag
    type:
      - 'null'
      - string
    doc: Gene Strand tag. For a given gene name <GENE_NAME_TAG>, this is the 
      strand of the gene.
    inputBinding:
      position: 101
      prefix: --GENE_STRAND_TAG
  - id: input_file
    type: File
    doc: The input SAM or BAM file to analyze
    inputBinding:
      position: 101
      prefix: --INPUT
  - id: jvm_heap_size
    type:
      - 'null'
      - string
    doc: Heap size to allocate for the JVM.
    inputBinding:
      position: 101
      prefix: -m
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
  - id: pct_required_overlap
    type:
      - 'null'
      - float
    doc: What fraction of the read must overlap a locus function to be included 
      in the annotation. If this parameter is set to 0, then if any bases are 
      overlap an annotation it is included in the output. StarSolo / CellRanger 
      would set this to 50.0, then only functional annotations with > 50% 
      overlap would be included. This forces a gene to have at most one 
      annotation (coding, intronic, etc) instead of multiple annotations (coding
      + intronic). Set to 0 to reproduce the DropSeq standard, or 50 to emulate 
      StarSolo.
    inputBinding:
      position: 101
      prefix: --PCT_REQUIRED_OVERLAP
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Whether to suppress job-summary info on System.err.
    inputBinding:
      position: 101
      prefix: --QUIET
  - id: read_function_tag
    type:
      - 'null'
      - string
    doc: READ functional annotation tag. For this read, what is the function? 
      This only looks at reads on the right strand, and prioritizes coding over 
      intron over intergenic. There is only 1 value for this tag.
    inputBinding:
      position: 101
      prefix: --READ_FUNCTION_TAG
  - id: reference_sequence
    type:
      - 'null'
      - File
    doc: Reference sequence file.
    inputBinding:
      position: 101
      prefix: --REFERENCE_SEQUENCE
  - id: show_hidden
    type:
      - 'null'
      - boolean
    doc: display hidden arguments
    inputBinding:
      position: 101
      prefix: --showHidden
  - id: summary
    type:
      - 'null'
      - File
    doc: The strand specific summary info
    inputBinding:
      position: 101
      prefix: --SUMMARY
  - id: tmp_dir
    type:
      - 'null'
      - type: array
        items: File
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
  - id: use_strand_info
    type:
      - 'null'
      - boolean
    doc: Use strand info to determine what gene to assign the read to. If this 
      is on, reads can be assigned to a maximum one one gene. This is used for 
      the READ_FUNCTION_TAG output only.
    inputBinding:
      position: 101
      prefix: --USE_STRAND_INFO
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
  - id: verbosity
    type:
      - 'null'
      - string
    doc: Control verbosity of logging.
    inputBinding:
      position: 101
      prefix: --VERBOSITY
outputs:
  - id: output_file
    type: File
    doc: The output BAM, written with new Gene/Exon tag
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dropseq_tools:3.0.2--hdfd78af_0
