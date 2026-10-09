cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - iobrpy
  - trust4
label: iobrpy_trust4
doc: "Run TRUST4 (TCR/BCR reconstruction) with IOBRpy defaults for the V/D/J/C reference
  files, then summarise the reports in trust4_immdata.csv and trust4_immune_indices.csv.\n\nTool
  homepage: https://github.com/IOBR/IOBRpy"
inputs:
  - id: bam
    type:
      - 'null'
      - File
    doc: Path to a BAM file (a directory of BAM files is only supported for batch runs)
    inputBinding:
      position: 101
      prefix: '-b'
  - id: read1
    type:
      - 'null'
      - File
    doc: Paired-end read 1 FASTQ
    inputBinding:
      position: 101
      prefix: '-1'
  - id: read2
    type:
      - 'null'
      - File
    doc: Paired-end read 2 FASTQ
    inputBinding:
      position: 101
      prefix: '-2'
  - id: single_end_reads
    type:
      - 'null'
      - File
    doc: Single-end read FASTQ
    inputBinding:
      position: 101
      prefix: '-u'
  - id: fqdir
    type:
      - 'null'
      - Directory
    doc: Directory containing paired FASTQs (*.fastq.gz) with suffixes _1/_2 (batch mode)
    inputBinding:
      position: 101
      prefix: '--fqdir'
  - id: v_d_j_c_fasta
    type:
      - 'null'
      - File
    doc: FASTA with coordinates and sequences of V/D/J/C genes (IOBRpy default is hg38_bcrtcr.fa)
    inputBinding:
      position: 101
      prefix: '-f'
  - id: imgt_reference
    type:
      - 'null'
      - File
    doc: Detailed V/D/J/C reference FASTA from IMGT (IOBRpy default is human_IMGT+C.fa)
    inputBinding:
      position: 101
      prefix: '--ref'
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Single-run - output prefix; batch - output root directory
    inputBinding:
      position: 101
      prefix: '-o'
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: '-t'
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: Starting k-mer size for indexing contigs
    inputBinding:
      position: 101
      prefix: '-k'
  - id: barcode
    type:
      - 'null'
      - string
    doc: Barcode field (BAM) or barcode file
    inputBinding:
      position: 101
      prefix: '--barcode'
  - id: barcode_level
    type:
      - 'null'
      - string
    doc: Barcode is for cell or molecule
    inputBinding:
      position: 101
      prefix: '--barcodeLevel'
  - id: barcode_whitelist
    type:
      - 'null'
      - File
    doc: Barcode whitelist
    inputBinding:
      position: 101
      prefix: '--barcodeWhitelist'
  - id: barcode_translate
    type:
      - 'null'
      - File
    doc: Barcode translate file
    inputBinding:
      position: 101
      prefix: '--barcodeTranslate'
  - id: umi
    type:
      - 'null'
      - string
    doc: UMI field (BAM) or UMI file
    inputBinding:
      position: 101
      prefix: '--UMI'
  - id: read_format
    type:
      - 'null'
      - string
    doc: Format for read, barcode and UMI files
    inputBinding:
      position: 101
      prefix: '--readFormat'
  - id: repseq
    type:
      - 'null'
      - boolean
    doc: Data is from bulk, non-UMI-based TCR-seq or BCR-seq
    inputBinding:
      position: 101
      prefix: '--repseq'
  - id: contig_min_cov
    type:
      - 'null'
      - int
    doc: Ignore contigs that have bases covered by fewer than this many reads
    inputBinding:
      position: 101
      prefix: '--contigMinCov'
  - id: min_hit_len
    type:
      - 'null'
      - int
    doc: Minimal hit length for a valid overlap
    inputBinding:
      position: 101
      prefix: '--minHitLen'
  - id: mate_id_suffix_len
    type:
      - 'null'
      - int
    doc: Suffix length in read id for mate
    inputBinding:
      position: 101
      prefix: '--mateIdSuffixLen'
  - id: skip_mate_extension
    type:
      - 'null'
      - boolean
    doc: Do not extend assemblies with mate information
    inputBinding:
      position: 101
      prefix: '--skipMateExtension'
  - id: abnormal_unmap_flag
    type:
      - 'null'
      - boolean
    doc: The flag in BAM for the unmapped read-pair is nonconcordant
    inputBinding:
      position: 101
      prefix: '--abnormalUnmapFlag'
  - id: assemble_with_ref
    type:
      - 'null'
      - boolean
    doc: Assemble with the --ref file
    inputBinding:
      position: 101
      prefix: '--assembleWithRef'
  - id: no_extraction
    type:
      - 'null'
      - boolean
    doc: Directly use the provided FASTQ files to assemble
    inputBinding:
      position: 101
      prefix: '--noExtraction'
  - id: output_read_assignment
    type:
      - 'null'
      - boolean
    doc: Output read assignment results to the prefix_assign.out file
    inputBinding:
      position: 101
      prefix: '--outputReadAssignment'
  - id: stage
    type:
      - 'null'
      - int
    doc: Start TRUST4 at this stage (0 begin, 1 assembly, 2 annotation, 3 report)
    inputBinding:
      position: 101
      prefix: '--stage'
  - id: clean
    type:
      - 'null'
      - int
    doc: Clean up files (0 keep all, 1 clean intermediates, 2 only keep AIRR files)
    inputBinding:
      position: 101
      prefix: '--clean'
  - id: od
    type: string
    doc: Output directory for the TRUST4 results and the immune summary tables
    inputBinding:
      position: 102
      prefix: '--od'
outputs:
  - id: output_directory
    type: Directory
    doc: Directory with the TRUST4 reports, AIRR file and immune summary tables
    outputBinding:
      glob: $(inputs.od)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
