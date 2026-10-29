cwlVersion: v1.2
class: CommandLineTool
baseCommand: [isoseq, cluster2]
label: nf-isoseq_isoseq_cluster2
doc: "Cluster FLNC reads and generate transcripts, much faster than \"cluster\" (FLNC to TRANSCRIPTS)

Tool homepage: https://github.com/PacificBiosciences/pbbioconda"
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: TMPDIR
        envValue: /tmp/
inputs:
  - id: flnc_bam
    type: File
    doc: "Input flnc BAM, ConsensusReadSet XML, or FOFN"
    secondaryFiles:
      - pattern: .pbi
        required: false
    inputBinding:
      position: 1
  - id: transcripts_output
    type: string
    doc: "Output transcripts BAM"
    inputBinding:
      position: 2
  - id: singletons
    type: ['null', boolean]
    doc: "Output FLNCs that could not be clustered."
    inputBinding:
      position: 100
      prefix: --singletons
  - id: sort_threads
    type: ['null', int]
    doc: "Number of sorting threads per BAM file. Defaults to num_threads. [0]"
    inputBinding:
      position: 100
      prefix: --sort-threads
  - id: write_bam
    type: ['null', string]
    doc: "Write annotated BAM file."
    inputBinding:
      position: 100
      prefix: --write-bam
  - id: log_level
    type: ['null', string]
    doc: "Set log level. Valid choices: (TRACE, DEBUG, INFO, WARN, FATAL). [WARN]"
    inputBinding:
      position: 100
      prefix: --log-level
  - id: log_file
    type: ['null', string]
    doc: "Log to a file, instead of stderr."
    inputBinding:
      position: 100
      prefix: --log-file
  - id: num_threads
    type: ['null', int]
    doc: "Number of threads to use, 0 means autodetection. [0]"
    inputBinding:
      position: 100
      prefix: --num-threads
outputs:
  - id: transcripts_bam
    type: File
    doc: "Transcripts BAM"
    secondaryFiles:
      - pattern: .pbi
        required: false
    outputBinding:
      glob: $(inputs.transcripts_output)
  - id: cluster_report
    type: ['null', File]
    doc: "Cluster report CSV"
    outputBinding:
      glob: $(inputs.transcripts_output.replace(/\.(bam|xml)$/, '')).cluster_report.csv
  - id: annotated_bam
    type: ['null', File]
    doc: "Annotated BAM (with write_bam)"
    secondaryFiles:
      - pattern: .pbi
        required: false
    outputBinding:
      glob: $(inputs.write_bam)
  - id: singletons_bam
    type: ['null', File]
    doc: "Singletons BAM (with singletons)"
    outputBinding:
      glob: $(inputs.transcripts_output.replace(/\.(bam|xml)$/, '')).singletons.bam
  - id: log_output
    type: ['null', File]
    doc: "Log file (when log_file is set)"
    outputBinding:
      glob: $(inputs.log_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isoseq:4.3.0--h9ee0642_0
