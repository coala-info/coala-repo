cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - isoseq
  - cluster2
label: isoseq3_cluster2
doc: "Cluster FLNC reads and generate transcripts, much faster than \"cluster\" (FLNC to TRANSCRIPTS)\n\nTool homepage: https://github.com/PacificBiosciences/IsoSeq3"
inputs:
  - id: flnc_input
    type: File
    doc: "Input flnc BAM."
    inputBinding:
      position: 1
  - id: transcripts_output
    type: string
    default: transcripts.bam
    doc: "Output transcripts BAM."
    inputBinding:
      position: 2
  - id: singletons
    type: ['null', boolean]
    doc: "Output FLNCs that could not be clustered."
    inputBinding:
      position: 103
      prefix: --singletons
  - id: sort_threads
    type: ['null', int]
    doc: "Number of sorting threads per BAM file. Equivalent to open file handles per BAM. Defaults to -j."
    inputBinding:
      position: 103
      prefix: --sort-threads
  - id: write_bam_path
    type: ['null', string]
    doc: "Write annotated BAM file."
    inputBinding:
      position: 103
      prefix: --write-bam
  - id: num_threads
    type: ['null', int]
    doc: "Number of threads to use, 0 means autodetection."
    inputBinding:
      position: 103
      prefix: --num-threads
  - id: log_level
    type: ['null', string]
    doc: "Set log level. Valid choices: (TRACE, DEBUG, INFO, WARN, FATAL)."
    inputBinding:
      position: 103
      prefix: --log-level
  - id: log_file_path
    type: ['null', string]
    doc: "Log to a file, instead of stderr."
    inputBinding:
      position: 103
      prefix: --log-file
outputs:
  - id: transcripts_bam
    type: File
    doc: "Output transcripts BAM."
    outputBinding:
      glob: $(inputs.transcripts_output)
  - id: transcripts_bam_index
    type: ['null', File]
    doc: "PacBio BAM index of the output BAM."
    outputBinding:
      glob: $(inputs.transcripts_output).pbi
  - id: cluster_report_csv
    type: ['null', File]
    doc: "Cluster report."
    outputBinding:
      glob: $(inputs.transcripts_output.replace(/\.bam$/, '')).cluster_report.csv
  - id: annotated_bam
    type: ['null', File]
    doc: "Annotated BAM, when write_bam_path is set."
    outputBinding:
      glob: $(inputs.write_bam_path)
  - id: log_file
    type: ['null', File]
    doc: "Log file, when log_file_path is set."
    outputBinding:
      glob: $(inputs.log_file_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: TMPDIR
        envValue: "/tmp/"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isoseq3:4.0.0--h9ee0642_0
