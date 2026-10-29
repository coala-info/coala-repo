cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - read_utils.py
  - index_fasta_picard
label: viral-ngs_read_utils_index_fasta_picard
doc: "Create an index file for a reference genome suitable for Picard/GATK.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: in_fasta
    type: File
    doc: "Input reference genome, FASTA format. It is staged writable because the index is written beside it."
    inputBinding:
      position: 1
  - id: jvm_memory
    type:
      - 'null'
      - string
    doc: "JVM virtual memory size (default: 512m)"
    inputBinding:
      position: 20
      prefix: --JVMmemory
  - id: picard_options
    type:
      - 'null'
      - type: array
        items: string
    doc: "Optional arguments to Picard's CreateSequenceDictionary, OPTIONNAME=value ..."
    inputBinding:
      position: 30
      prefix: --picardOptions
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: dict_file
    type: File
    doc: "Picard sequence dictionary (.dict)"
    outputBinding:
      glob: $(inputs.in_fasta.nameroot).dict
  - id: fai_file
    type:
      - 'null'
      - File
    doc: "Samtools .fai index, if written"
    outputBinding:
      glob: $(inputs.in_fasta.basename).fai
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.in_fasta)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs_read_utils_index_fasta_picard.out
