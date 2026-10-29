cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - assembly.py
  - trim_rmdup_subsamp
label: viral-ngs_assembly_trim_rmdup_subsamp
doc: "Take reads through Trimmomatic, Prinseq, and subsampling. This should probably move over to read_utils or taxon_filter.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: in_bam
    type: File
    doc: "Input reads, unaligned BAM format."
    inputBinding:
      position: 1
  - id: clip_db
    type: File
    doc: "Trimmomatic clip DB."
    inputBinding:
      position: 2
  - id: out_bam
    type: string
    doc: "Output reads, unaligned BAM format (currently, read groups and other header information are destroyed in this process)."
    inputBinding:
      position: 3
  - id: n_reads
    type:
      - 'null'
      - int
    doc: "Subsample reads to no more than this many individual reads. Note that paired reads are given priority, and unpaired reads are included to reach the count if there are too few paired reads to reach n_reads. (default 100000)"
    inputBinding:
      position: 20
      prefix: --n_reads
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
      position: 20
      prefix: --tmp_dir
  - id: tmp_dir_keep
    type:
      - 'null'
      - boolean
    doc: "Keep the tmp_dir if an exception occurs while running. Default is to delete all temp files at the end, even if there's a failure."
    inputBinding:
      position: 20
      prefix: --tmp_dirKeep
outputs:
  - id: out_bam_file
    type: File
    doc: "Output file written to out_bam"
    outputBinding:
      glob: $(inputs.out_bam)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
