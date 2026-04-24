cwlVersion: v1.2
class: CommandLineTool
baseCommand: DigitalExpression
label: dropseq_tools_DigitalExpression
doc: "Measures the digital expression of a library. Method: 1) For each gene, find
  the molecular barcodes on the exons of that gene. 2) Determine how many HQ mapped
  reads are assigned to each barcode. 3) Collapse barcodes by edit distance. 4) Throw
  away barcodes with less than threshold # of reads. 5) Count the number of remaining
  unique molecular barcodes for the gene.This program requires a tag for what gene
  a read is on, a molecular barcode tag, and a exon tag. The exon and gene tags may
  not be present on every read.When filtering the data for a set of barcodes to use,
  the data is filtered by ONE of the following methods (and if multiple params are
  filled in, the top one takes precedence):1) CELL_BC_FILE, to filter by the some
  fixed list of cell barcodes2) MIN_NUM_GENES_PER_CELL 3) MIN_NUM_TRANSCRIPTS_PER_CELL
  4) NUM_CORE_BARCODES 5) MIN_NUM_READS_PER_CELL\n\nTool homepage: http://mccarrolllab.com/dropseq/"
inputs:
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: read one or more arguments files and add them to the command line
    inputBinding:
      position: 101
      prefix: --arguments_file
  - id: cell_barcode_tag
    type:
      - 'null'
      - string
    doc: The cell barcode tag. If there are no reads with this tag, the program 
      will assume that all reads belong to the same cell and process in single 
      sample mode.
    inputBinding:
      position: 101
      prefix: --CELL_BARCODE_TAG
  - id: cell_bc_file
    type:
      - 'null'
      - File
    doc: Override CELL_BARCODE and MIN_NUM_READS_PER_CELL, and process reads 
      that have the cell barcodes in this file instead. The file has 1 column 
      with no header.
    inputBinding:
      position: 101
      prefix: --CELL_BC_FILE
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
  - id: echo_command_line
    type:
      - 'null'
      - boolean
    doc: Echo final command line before executing.
    inputBinding:
      position: 101
      prefix: -v
  - id: edit_distance
    type:
      - 'null'
      - int
    doc: The edit distance that molecular barcodes should be combined at within 
      a gene.
    inputBinding:
      position: 101
      prefix: --EDIT_DISTANCE
  - id: functional_strategy
    type:
      - 'null'
      - string
    doc: A strategy for interpreting functional annotations. DropSeq is the 
      default strategy. STARSOLO strategy priority is very similar to DropSeq, 
      exceptin cases where a read overlaps both an intron on the sense strand 
      and a coding region on the antisense strand. In these cases, DropSeq 
      favors the intronic interpretation, while STARSolo interprets this as a 
      technical artifact and labels the read as coming from the antisense coding
      gene, and the read does not contribute to the expression counts matrix.
    inputBinding:
      position: 101
      prefix: --FUNCTIONAL_STRATEGY
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
    doc: The input SAM or BAM file to analyze.
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
  - id: locus_function_list
    type:
      - 'null'
      - type: array
        items: string
    doc: A list of functional annotations that reads need to be completely 
      contained by to be considered for analysis.
    inputBinding:
      position: 101
      prefix: --LOCUS_FUNCTION_LIST
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
  - id: min_bc_read_threshold
    type:
      - 'null'
      - int
    doc: The minimum number of reads a molecular barcode should have to be 
      considered. This is done AFTER edit distance collapse of barcodes.
    inputBinding:
      position: 101
      prefix: --MIN_BC_READ_THRESHOLD
  - id: min_num_genes_per_cell
    type:
      - 'null'
      - int
    doc: The minumum number of genes for a cell barcode to be reported.
    inputBinding:
      position: 101
      prefix: --MIN_NUM_GENES_PER_CELL
  - id: min_num_reads_per_cell
    type:
      - 'null'
      - int
    doc: Gather up all cell barcodes that have more than some number of reads.
    inputBinding:
      position: 101
      prefix: --MIN_NUM_READS_PER_CELL
  - id: min_num_transcripts_per_cell
    type:
      - 'null'
      - int
    doc: The minumum number of transcripts for a cell barcode to be reported.
    inputBinding:
      position: 101
      prefix: --MIN_NUM_TRANSCRIPTS_PER_CELL
  - id: min_sum_expression
    type:
      - 'null'
      - int
    doc: Output only genes with at least this total expression level, after 
      summing across all cells
    inputBinding:
      position: 101
      prefix: --MIN_SUM_EXPRESSION
  - id: molecular_barcode_tag
    type:
      - 'null'
      - string
    doc: The molecular barcode tag.
    inputBinding:
      position: 101
      prefix: --MOLECULAR_BARCODE_TAG
  - id: num_core_barcodes
    type:
      - 'null'
      - int
    doc: Number of cells that you think are in the library. The largest <X> 
      barcodes are used.
    inputBinding:
      position: 101
      prefix: --NUM_CORE_BARCODES
  - id: omit_missing_cells
    type:
      - 'null'
      - boolean
    doc: When using CELL_BC_FILE, do not emit a column for a cell barcode that 
      appears in CELL_BC_FILE if it does not appear in the input BAM.
    inputBinding:
      position: 101
      prefix: --OMIT_MISSING_CELLS
  - id: output_header
    type:
      - 'null'
      - boolean
    doc: If true, write a header in the DGE file. If not specified, and UEI is 
      specified, it is set to true. REFERENCE_SEQUENCE only used to write to 
      header. If it is not present, it is extracted from INPUT header if 
      possible.
    inputBinding:
      position: 101
      prefix: --OUTPUT_HEADER
  - id: output_long_format
    type:
      - 'null'
      - File
    doc: An alternate output of expression where each row represents a cell, 
      gene, and count of UMIs. Cell/Gene pairings with 0 UMIs are not emitted.
    inputBinding:
      position: 101
      prefix: --OUTPUT_LONG_FORMAT
  - id: output_reads_instead
    type:
      - 'null'
      - boolean
    doc: Output number of reads instead of number of unique molecular barcodes.
    inputBinding:
      position: 101
      prefix: --OUTPUT_READS_INSTEAD
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Whether to suppress job-summary info on System.err.
    inputBinding:
      position: 101
      prefix: --QUIET
  - id: rare_umi_filter_threshold
    type:
      - 'null'
      - float
    doc: Drop UMIs within a cell/gene pair that occur less than the average 
      number of reads*<FILTER_FREQ> for all UMIs in the cell/gene pair. For 
      example, if you had on average 1000 reads per UMI and a UMI with 1-10 
      reads, those small UMIs would be removed when this frequency was set to 
      0.01.This is off by default. A sensible value might be 0.01.
    inputBinding:
      position: 101
      prefix: --RARE_UMI_FILTER_THRESHOLD
  - id: read_mq
    type:
      - 'null'
      - int
    doc: "The map quality of the read to be included. Experimental: While the default
      map quality is 10 (uniquereads), lower map quality can now be set to recover
      reads that map to multiple places in the genome. This mirrors STARsolo's approach,
      where all mapping positions for a read are considered, and the read is includedin
      downstream analysis if the read maps consistently to a single gene given all
      other thresholds (functional annotations, strand). To reproduce STARSolo's expression
      output of these reads, set this value to 0 to include all reads."
    inputBinding:
      position: 101
      prefix: --READ_MQ
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
  - id: strand_strategy
    type:
      - 'null'
      - string
    doc: The strand strategy decides which reads will be used by analysis. The 
      SENSE strategy requires the read and annotation to have the same strand. 
      The ANTISENSE strategy requires the read and annotation to be on opposite 
      strands. The BOTH strategy is permissive, and allows the read to be on 
      either strand.
    inputBinding:
      position: 101
      prefix: --STRAND_STRATEGY
  - id: summary
    type:
      - 'null'
      - File
    doc: 'A summary of the digital expression output, containing 3 columns - the cell
      barcode, the #genes, and the #transcripts.'
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
  - id: unique_experiment_id
    type:
      - 'null'
      - string
    doc: If OUTPUT_HEADER=true, this is required
    inputBinding:
      position: 101
      prefix: --UNIQUE_EXPERIMENT_ID
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
    doc: Output file of DGE Matrix. Genes are in rows, cells in columns. The 
      first column contains the gene name. This supports zipped formats like gz 
      and bz2.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dropseq_tools:3.0.2--hdfd78af_0
