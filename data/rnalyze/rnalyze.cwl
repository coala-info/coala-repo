cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnalyze
label: rnalyze
doc: "RNA-Seq Analysis Pipeline: A comprehensive tool for RNA-Seq data processing,
  alignment, and analysis.\n\nTool homepage: https://github.com/MohamedElsisii/rnalyze"
inputs:
  - id: adapter_pe
    type:
      - 'null'
      - string
    doc: "Adapter sequence for Paired-End data (required if --type PE & --trim-tool
      trimmomatic): - NexteraPE-PE: Nextera Paired-End adapter. - TruSeq2-PE: TruSeq2
      Paired-End adapter. - TruSeq3-PE: TruSeq3 Paired-End adapter. - TruSeq3-PE-2:
      TruSeq3 Paired-End adapter. 3' adapter sequence for Paired-End data (required
      if --type PE & --trim-tool cutadapt): - Example: AGATCGGAAGAGC."
    inputBinding:
      position: 101
      prefix: --adapter-pe
  - id: adapter_se
    type:
      - 'null'
      - string
    doc: "Adapter sequence for Single-End data (required if --type SE & --trim-tool
      trimmomatic): - TruSeq2-SE: TruSeq2 Single-End adapter. - TruSeq3-SE: TruSeq3
      Single-End adapter. 3' adapter sequence for Single-End data (required if --type
      SE & --trim-tool cutadapt): - Example: AGATCGGAAGAGC."
    inputBinding:
      position: 101
      prefix: --adapter-se
  - id: data
    type: string
    doc: 'Specify how to handle input data: - Download: Download data using SRR accession
      numbers. - Directory: Use data from a local directory.'
    inputBinding:
      position: 101
      prefix: --data
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: Directory containing input data (required if --data Directory). The 
      directory should contain .fastq.gz files.
    inputBinding:
      position: 101
      prefix: --data-dir
  - id: front_pe
    type:
      - 'null'
      - string
    doc: "5' adapter sequence for Paired-End data (optional if --type PE & --trim-tool
      cutadapt): - Example: AGATCGGAAGAGC."
    inputBinding:
      position: 101
      prefix: --front-pe
  - id: front_se
    type:
      - 'null'
      - string
    doc: "5' adapter sequence for Single-End data (optional if --type SE & --trim-tool
      cutadapt): - Example: AGATCGGAAGAGC."
    inputBinding:
      position: 101
      prefix: --front-se
  - id: gtf
    type:
      - 'null'
      - string
    doc: 'Specify how to handle the GTF file: - Download: Download the GTF file from
      a URL. - Path: Use a GTF file from a local path.'
    inputBinding:
      position: 101
      prefix: --gtf
  - id: gtf_path
    type:
      - 'null'
      - File
    doc: Path to the GTF file (required if --gtf Path).
    inputBinding:
      position: 101
      prefix: --gtf-path
  - id: gtf_url
    type:
      - 'null'
      - string
    doc: URL for downloading the GTF file (required if --gtf Download).
    inputBinding:
      position: 101
      prefix: --gtf-url
  - id: identifier
    type:
      - 'null'
      - string
    doc: 'Gene identifier attribute in the GTF file (default: gene_id). This is used
      for feature counting.'
    default: gene_id
    inputBinding:
      position: 101
      prefix: --identifier
  - id: leading
    type:
      - 'null'
      - int
    doc: Remove bases with quality below this threshold from the start of the 
      read.
    default: 3
    inputBinding:
      position: 101
      prefix: --leading
  - id: min_read_len
    type:
      - 'null'
      - int
    doc: Discard reads shorter than this length after trimming.
    default: 30
    inputBinding:
      position: 101
      prefix: --min-read-len
  - id: minlen
    type:
      - 'null'
      - int
    doc: Discard reads shorter than this length after trimming.
    default: 36
    inputBinding:
      position: 101
      prefix: --minlen
  - id: pipeline
    type: string
    doc: 'Specify the pipeline type: - Full: Perform full analysis (trimming, alignment,
      counting). - Alignment: Perform only alignment (no counting).'
    inputBinding:
      position: 101
      prefix: --pipeline
  - id: quality_cut
    type:
      - 'null'
      - int
    doc: Trim bases with quality below this threshold.
    default: 20
    inputBinding:
      position: 101
      prefix: --quality-cut
  - id: ref
    type: string
    doc: 'Specify how to handle the reference genome: - UnindexedURL: Download and
      index an unindexed reference genome from URL. - IndexedURL: Download a pre-indexed
      reference genome from URL. - IndexedPath: Use a pre-indexed reference genome
      from a local path. - UnindexedPath: Use an unindexed reference genome from a
      local path.'
    inputBinding:
      position: 101
      prefix: --ref
  - id: ref_path
    type:
      - 'null'
      - File
    doc: Path to the reference genome files (required if --ref IndexedPath or 
      UnindexedPath).
    inputBinding:
      position: 101
      prefix: --ref-path
  - id: ref_url
    type:
      - 'null'
      - string
    doc: URL for downloading the reference genome (required if --ref 
      UnindexedURL or IndexedURL).
    inputBinding:
      position: 101
      prefix: --ref-url
  - id: sliding_win
    type:
      - 'null'
      - string
    doc: 'Perform sliding window trimming with window size and average quality. Format:
      WINDOW_SIZE:QUALITY_THRESHOLD (e.g., 4:25).'
    default: 4:25
    inputBinding:
      position: 101
      prefix: --sliding-win
  - id: srr_path
    type:
      - 'null'
      - File
    doc: Path to SRR_Acc_List.txt (required if --data Download). This file 
      should contain a list of SRR accession numbers.
    inputBinding:
      position: 101
      prefix: --srr-path
  - id: tool
    type: string
    doc: 'Specify the alignment tool: - BWA: Burrows-Wheeler Aligner. - Bowtie2: Bowtie2
      aligner. - HISAT2: Hierarchical Indexing for Spliced Transcripts.'
    inputBinding:
      position: 101
      prefix: --tool
  - id: trailing
    type:
      - 'null'
      - int
    doc: Remove bases with quality below this threshold from the end of the 
      read.
    default: 3
    inputBinding:
      position: 101
      prefix: --trailing
  - id: trim
    type:
      - 'null'
      - string
    doc: 'Enable or disable trimming: - yes: Enable trimming. - no: Disable trimming.'
    inputBinding:
      position: 101
      prefix: --trim
  - id: trim_tool
    type:
      - 'null'
      - string
    doc: 'Specify the trimming tool (required if --trim yes): - Trimmomatic: Use Trimmomatic
      for trimming. - Cutadapt: Use Cutadapt for trimming.'
    inputBinding:
      position: 101
      prefix: --trim-tool
  - id: type
    type: string
    doc: 'Specify the RNA-Seq data type: - SE: Single-End data. - PE: Paired-End data.'
    inputBinding:
      position: 101
      prefix: --type
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnalyze:1.0.1--hdfd78af_1
stdout: rnalyze.out
