cwlVersion: v1.2
class: CommandLineTool
baseCommand: run-trust4
label: trust4_run-trust4
doc: "TRUST4 pipeline wrapper: extracts candidate reads, assembles contigs, annotates CDR3 and writes the TCR/BCR repertoire report.\n\nTool homepage: https://github.com/liulab-dfci/TRUST4"
inputs:
  - id: bam_file
    type:
      - 'null'
      - File
    doc: "path to bam file"
    inputBinding:
      position: 101
      prefix: -b
  - id: read1
    type:
      - 'null'
      - File
    doc: "path to paired-end read file 1"
    inputBinding:
      position: 101
      prefix: "-1"
  - id: read2
    type:
      - 'null'
      - File
    doc: "path to paired-end read file 2"
    inputBinding:
      position: 101
      prefix: "-2"
  - id: single_end_read
    type:
      - 'null'
      - File
    doc: "path to single-end read file"
    inputBinding:
      position: 101
      prefix: -u
  - id: fasta_file
    type: File
    doc: "path to the fasta file coordinate and sequence of V/D/J/C genes"
    inputBinding:
      position: 101
      prefix: -f
  - id: ref
    type:
      - 'null'
      - File
    doc: "path to detailed V/D/J/C gene reference file from IMGT database (recommended)"
    inputBinding:
      position: 101
      prefix: --ref
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: "prefix of output files (default: inferred from file prefix)"
    inputBinding:
      position: 101
      prefix: -o
  - id: od
    type:
      - 'null'
      - string
    doc: "the directory for output files (default: ./)"
    inputBinding:
      position: 101
      prefix: --od
  - id: threads
    type:
      - 'null'
      - int
    doc: "number of threads (default: 1)"
    inputBinding:
      position: 101
      prefix: -t
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: "the starting k-mer size for indexing contigs (default: 9)"
    inputBinding:
      position: 101
      prefix: -k
  - id: barcode
    type:
      - 'null'
      - string
    doc: "if -b, bam field for barcode; if -1 -2/-u, file containing barcodes (default: not used)"
    inputBinding:
      position: 101
      prefix: --barcode
  - id: barcode_level
    type:
      - 'null'
      - string
    doc: "barcode is for cell or molecule (default: cell)"
    inputBinding:
      position: 101
      prefix: --barcodeLevel
  - id: barcode_whitelist
    type:
      - 'null'
      - File
    doc: "path to the barcode whitelist (default: not used)"
    inputBinding:
      position: 101
      prefix: --barcodeWhitelist
  - id: barcode_translate
    type:
      - 'null'
      - File
    doc: "path to the barcode translate file (default: not used)"
    inputBinding:
      position: 101
      prefix: --barcodeTranslate
  - id: umi
    type:
      - 'null'
      - string
    doc: "if -b, bam field for 10x Genomics-like UMI; if -1 -2/-u, file containing 10x Genomics-like UMIs (default: not used)"
    inputBinding:
      position: 101
      prefix: --UMI
  - id: read_format
    type:
      - 'null'
      - string
    doc: "format for read, barcode and UMI files (example: r1:0:-1,r2:0:-1,bc:0:15,um:16:-1)"
    inputBinding:
      position: 101
      prefix: --readFormat
  - id: repseq
    type:
      - 'null'
      - boolean
    doc: "the data is from bulk, non-UMI-based TCR-seq or BCR-seq (default: not set)"
    inputBinding:
      position: 101
      prefix: --repseq
  - id: contig_min_cov
    type:
      - 'null'
      - int
    doc: "ignore contigs that have bases covered by fewer than INT reads (default: 0)"
    inputBinding:
      position: 101
      prefix: --contigMinCov
  - id: min_hit_len
    type:
      - 'null'
      - int
    doc: "the minimal hit length for a valid overlap (default: auto)"
    inputBinding:
      position: 101
      prefix: --minHitLen
  - id: mate_id_suffix_len
    type:
      - 'null'
      - int
    doc: "the suffix length in read id for mate (default: not used)"
    inputBinding:
      position: 101
      prefix: --mateIdSuffixLen
  - id: skip_mate_extension
    type:
      - 'null'
      - boolean
    doc: "do not extend assemblies with mate information, useful for SMART-seq"
    inputBinding:
      position: 101
      prefix: --skipMateExtension
  - id: skip_read_realign
    type:
      - 'null'
      - boolean
    doc: "do not realign reads in annotator, useful for reducing computation cost of barcode/UMI-based repseq"
    inputBinding:
      position: 101
      prefix: --skipReadRealign
  - id: cgene_end
    type:
      - 'null'
      - int
    doc: "skip reads aligned after the first INT bp of the C gene (default: 200)"
    inputBinding:
      position: 101
      prefix: --cgeneEnd
  - id: abnormal_unmap_flag
    type:
      - 'null'
      - boolean
    doc: "the flag in BAM for the unmapped read-pair is nonconcordant (default: not set)"
    inputBinding:
      position: 101
      prefix: --abnormalUnmapFlag
  - id: no_extraction
    type:
      - 'null'
      - boolean
    doc: "directly use the files from provided -1 -2/-u to assemble (default: extraction first)"
    inputBinding:
      position: 101
      prefix: --noExtraction
  - id: imgt_additional_gap
    type:
      - 'null'
      - string
    doc: "description for additional gap codon position in IMGT (0-based), e.g. \"TRAV:7,83\" for mouse"
    inputBinding:
      position: 101
      prefix: --imgtAdditionalGap
  - id: assemble_with_ref
    type:
      - 'null'
      - boolean
    doc: "conduct the assembly with --ref file (default: use -f file)"
    inputBinding:
      position: 101
      prefix: --assembleWithRef
  - id: output_read_assignment
    type:
      - 'null'
      - boolean
    doc: "output read assignment results to the prefix_assign.out file"
    inputBinding:
      position: 101
      prefix: --outputReadAssignment
  - id: stage
    type:
      - 'null'
      - int
    doc: "start TRUST4 on specified stage: 0 beginning, 1 assembly, 2 annotation, 3 report table (default: 0)"
    inputBinding:
      position: 101
      prefix: --stage
  - id: clean
    type:
      - 'null'
      - int
    doc: "clean up files. 0: no clean. 1: clean intermediate files. 2: only keep AIRR files (default: 0)"
    inputBinding:
      position: 101
      prefix: --clean
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: "Output files: prefix_report.tsv, prefix_airr.tsv, prefix_annot.fa, prefix_cdr3.out and others (default prefix TRUST_<input name>)"
    outputBinding:
      glob: "$((inputs.od ? inputs.od + '/' : '') + (inputs.output_prefix ? inputs.output_prefix : 'TRUST_') + '*')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trust4:1.1.8--h5ca1c30_0
