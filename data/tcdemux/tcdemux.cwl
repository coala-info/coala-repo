cwlVersion: v1.2
class: CommandLineTool
baseCommand: tcdemux
label: tcdemux
doc: "Demultiplexes sequencing reads based on sample information and adaptor sequences.\n\
  \nTool homepage: https://github.com/TomHarrop/tcdemux"
inputs:
  - id: adaptors
    type:
      type: array
      items: File
    doc: FASTA file(s) of adaptors. Multiple adaptor files can be used.
    inputBinding:
      position: 101
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Dry run
    inputBinding:
      position: 101
      prefix: -n
  - id: keep_intermediate_files
    type:
      - 'null'
      - boolean
    doc: Keep intermediate files
    inputBinding:
      position: 101
      prefix: --keep_intermediate_files
  - id: mem_gb
    type:
      - 'null'
      - int
    doc: Amount of RAM in GB.
    inputBinding:
      position: 101
  - id: no_keep_intermediate_files
    type:
      - 'null'
      - boolean
    doc: Do not keep intermediate files
    inputBinding:
      position: 101
      prefix: --no-keep_intermediate_files
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
  - id: read_directory
    type: Directory
    doc: Directory containing the read files
    inputBinding:
      position: 101
  - id: restart_times
    type:
      - 'null'
      - int
    doc: number of times to restart failing jobs
    inputBinding:
      position: 101
  - id: sample_data
    type: File
    doc: Sample csv (see README)
    inputBinding:
      position: 101
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads.
    inputBinding:
      position: 101
  - id: trimq
    type:
      - 'null'
      - int
    doc: Regions with average quality BELOW this will be trimmed, if qtrim is 
      enabled
    inputBinding:
      position: 101
outputs:
  - id: outdir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tcdemux:0.1.1--pyhdfd78af_0
