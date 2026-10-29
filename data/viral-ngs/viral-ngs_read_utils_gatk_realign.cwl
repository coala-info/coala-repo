cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - read_utils.py
  - gatk_realign
label: viral-ngs_read_utils_gatk_realign
doc: "Local realignment of BAM files with GATK IndelRealigner.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: in_bam
    type: File
    secondaryFiles:
      - pattern: .bai
        required: true
    doc: "Input reads, BAM format, aligned to refFasta. A .bai index must be beside it."
    inputBinding:
      position: 1
  - id: ref_fasta
    type: File
    secondaryFiles:
      - pattern: .fai
        required: true
      - pattern: ^.dict
        required: true
    doc: "Reference genome, FASTA format, pre-indexed by Picard (needs the .fai and .dict files beside it)."
    inputBinding:
      position: 2
  - id: out_bam
    type: string
    doc: "Realigned reads."
    inputBinding:
      position: 3
  - id: jvm_memory
    type:
      - 'null'
      - string
    doc: "JVM virtual memory size (default: 2g)"
    inputBinding:
      position: 20
      prefix: --JVMmemory
  - id: gatk_path
    type:
      - 'null'
      - string
    doc: "A path containing the GATK jar file. This overrides the GATK_ENV environment variable or the GATK conda package. (default: None)"
    inputBinding:
      position: 20
      prefix: --GATK_PATH
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
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads (default: 1)"
    inputBinding:
      position: 22
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: out_bam_file
    type: File
    doc: "Realigned bam file"
    outputBinding:
      glob: $(inputs.out_bam)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs_read_utils_gatk_realign.out
