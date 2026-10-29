cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - read_utils.py
  - bwamem_idxstats
label: viral-ngs_read_utils_bwamem_idxstats
doc: "Take reads, align to reference with BWA-MEM and perform samtools idxstats.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: in_bam
    type: File
    doc: "Input unaligned reads, BAM format."
    inputBinding:
      position: 1
  - id: ref_fasta
    type: File
    doc: "Reference genome, FASTA format, pre-indexed by Picard and Novoalign."
    inputBinding:
      position: 2
      valueFrom: $(self.basename)
  - id: out_bam
    type:
      - 'null'
      - string
    doc: "Output aligned, indexed BAM file"
    inputBinding:
      position: 20
      prefix: --outBam
  - id: out_stats
    type:
      - 'null'
      - string
    doc: "Output idxstats file"
    inputBinding:
      position: 20
      prefix: --outStats
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
    type:
      - 'null'
      - File
    doc: "Output file written to out_bam"
    outputBinding:
      glob: $(inputs.out_bam)
  - id: out_stats_file
    type:
      - 'null'
      - File
    doc: "Output file written to out_stats"
    outputBinding:
      glob: $(inputs.out_stats)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.ref_fasta)
        writable: true

hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
