cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxon_filter.py
  - deplete_human
label: viral-ngs_taxon_filter_deplete_human
doc: "Run the entire depletion pipeline: bmtagger, mvicuna, blastn. Optionally, use lastal to select a specific taxon of interest.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: in_bam
    type: File
    doc: "Input BAM file."
    inputBinding:
      position: 1
  - id: revert_bam
    type:
      - 'null'
      - string
    doc: "Output BAM: read markup reverted with Picard."
    inputBinding:
      position: 2
  - id: bmtagger_bam
    type: string
    doc: "Output BAM: depleted of human reads with BMTagger."
    inputBinding:
      position: 3
  - id: rmdup_bam
    type: string
    doc: "Output BAM: bmtaggerBam run through M-Vicuna duplicate removal."
    inputBinding:
      position: 4
  - id: blastn_bam
    type: string
    doc: "Output BAM: rmdupBam run through another depletion of human reads with BLASTN."
    inputBinding:
      position: 5
  - id: taxfilt_bam
    type:
      - 'null'
      - string
    doc: "Output BAM: blastnBam run through taxonomic selection via LASTAL."
    inputBinding:
      position: 20
      prefix: --taxfiltBam
  - id: bmtagger_dbs
    type:
      type: array
      items: string
    doc: "Reference databases (one or more) to deplete from input. For each db, requires prior creation of db.bitmask by bmtool, and db.srprism.idx, db.srprism.map, etc. by srprism mkindex."
    inputBinding:
      position: 20
      prefix: --bmtaggerDbs
  - id: blast_dbs
    type:
      type: array
      items: string
    doc: "One or more reference databases for blast to deplete from input."
    inputBinding:
      position: 20
      prefix: --blastDbs
  - id: last_db
    type:
      - 'null'
      - string
    doc: "One reference database for last (required if --taxfiltBam is specified)."
    inputBinding:
      position: 20
      prefix: --lastDb
  - id: threads
    type:
      - 'null'
      - int
    doc: "The number of threads to use in running blastn."
    inputBinding:
      position: 20
      prefix: --threads
  - id: jvm_memory
    type:
      - 'null'
      - string
    doc: "JVM virtual memory size for Picard FilterSamReads (default: 4g)"
    inputBinding:
      position: 20
      prefix: --JVMmemory
  - id: loglevel
    type:
      - 'null'
      - type: enum
        symbols:
          - DEBUG
          - INFO
          - WARNING
          - ERROR
          - CRITICAL
          - EXCEPTION
    doc: "Verboseness of output. [default: DEBUG]"
    inputBinding:
      position: 20
      prefix: --loglevel
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: "Base directory for temp files. [default: /tmp]"
    inputBinding:
      position: 21
      prefix: --tmp_dir
  - id: tmp_dir_keep
    type:
      - 'null'
      - boolean
    doc: "Keep the tmp_dir if an exception occurs while running. Default is to delete all temp files at the end, even if there's a failure."
    inputBinding:
      position: 21
      prefix: --tmp_dirKeep
  - id: ref_db_files
    type:
      type: array
      items: File
    doc: "Database files (bmtagger, blast and last), staged in the working directory so that the database prefixes resolve."
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: revert_bam_file
    type:
      - 'null'
      - File
    doc: "Reverted bam file"
    outputBinding:
      glob: $(inputs.revert_bam)
  - id: bmtagger_bam_file
    type: File
    doc: "BMTagger-depleted bam file"
    outputBinding:
      glob: $(inputs.bmtagger_bam)
  - id: rmdup_bam_file
    type: File
    doc: "Deduplicated bam file"
    outputBinding:
      glob: $(inputs.rmdup_bam)
  - id: blastn_bam_file
    type: File
    doc: "BLASTN-depleted bam file"
    outputBinding:
      glob: $(inputs.blastn_bam)
  - id: taxfilt_bam_file
    type:
      - 'null'
      - File
    doc: "Taxon-selected bam file"
    outputBinding:
      glob: $(inputs.taxfilt_bam)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.ref_db_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs_taxon_filter_deplete_human.out
