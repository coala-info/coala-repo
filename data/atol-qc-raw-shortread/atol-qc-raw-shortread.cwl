cwlVersion: v1.2
class: CommandLineTool
baseCommand: atol-qc-raw-shortread
label: atol-qc-raw-shortread
doc: "Performs quality control and trimming on raw short-read sequencing data.\n\n\
  Tool homepage: https://github.com/TomHarrop/atol-qc-raw-shortread"
inputs:
  - id: adaptors
    type:
      - 'null'
      - type: array
        items: File
    doc: FASTA file(s) of adaptors. Multiple adaptor files can be used.
    inputBinding:
      position: 101
      prefix: --adaptors
  - id: dataset_id
    type:
      - 'null'
      - string
    doc: Only for CRAM output. Will be added to the @RG header line.
    inputBinding:
      position: 101
      prefix: --dataset_id
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Perform a dry run without making any changes
    inputBinding:
      position: 101
      prefix: -n
  - id: hic_kit
    type:
      - 'null'
      - string
    doc: Only for CRAM output. Will be added to the @RG header line.
    inputBinding:
      position: 101
      prefix: --hic_kit
  - id: in1
    type: File
    doc: Read 1 input
    inputBinding:
      position: 101
      prefix: --in
  - id: in2
    type: File
    doc: Read 2 input
    inputBinding:
      position: 101
      prefix: --in2
  - id: no_qtrim
    type:
      - 'null'
      - boolean
    doc: Do not trim right end of reads.
    inputBinding:
      position: 101
      prefix: --no-qtrim
  - id: qtrim
    type:
      - 'null'
      - boolean
    doc: Trim right end of reads to remove bases with quality below trimq.
    inputBinding:
      position: 101
      prefix: --qtrim
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: trimq
    type:
      - 'null'
      - int
    doc: Regions with average quality BELOW this will be trimmed, if qtrim is 
      enabled
    inputBinding:
      position: 101
      prefix: --trimq
outputs:
  - id: cram_out
    type:
      - 'null'
      - File
    doc: CRAM output. For IO efficiency, you can output CRAM or fastq, but not 
      both. If you need both, convert the output afterwards.
    outputBinding:
      glob: $(inputs.cram_out)
  - id: r1_out
    type:
      - 'null'
      - File
    doc: Read 1 output. For IO efficiency, you can output CRAM or fastq, but not
      both. If you need both, convert the output afterwards.
    outputBinding:
      glob: $(inputs.r1_out)
  - id: r2_out
    type:
      - 'null'
      - File
    doc: Read 2 output
    outputBinding:
      glob: $(inputs.r2_out)
  - id: stats
    type: File
    doc: Stats output (json)
    outputBinding:
      glob: $(inputs.stats)
  - id: logs_directory
    type:
      - 'null'
      - Directory
    doc: 'Log output directory. Default: logs are discarded.'
    outputBinding:
      glob: $(inputs.logs_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atol-qc-raw-shortread:0.2.2--pyhdfd78af_0
