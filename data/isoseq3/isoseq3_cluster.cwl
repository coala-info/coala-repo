cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - isoseq
  - cluster
label: isoseq3_cluster
doc: "Cluster FLNC reads and generate transcripts (FLNC to TRANSCRIPTS)\n\nTool homepage: https://github.com/PacificBiosciences/IsoSeq3"
inputs:
  - id: flnc_input
    type: File
    doc: "Input flnc BAM."
    inputBinding:
      position: 1
  - id: transcripts_output
    type: string
    default: transcripts.bam
    doc: "Output transcripts BAM (the second positional argument names the output)."
    inputBinding:
      position: 2
  - id: poa_cov
    type: ['null', int]
    doc: "Maximum number of CCS reads used for POA consensus."
    inputBinding:
      position: 103
      prefix: --poa-cov
  - id: min_subreads_split
    type: ['null', int]
    doc: "Subread threshold for HQ/LQ split."
    inputBinding:
      position: 103
      prefix: --min-subreads-split
  - id: split_bam
    type: ['null', int]
    doc: "Split BAM output files into at maximum N files; 0 means no splitting."
    inputBinding:
      position: 103
      prefix: --split-bam
  - id: singletons
    type: ['null', boolean]
    doc: "Output FLNCs that could not be clustered."
    inputBinding:
      position: 103
      prefix: --singletons
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
  - id: verbose
    type: ['null', boolean]
    doc: "Use verbose output."
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: transcripts_bam
    type: File
    doc: "Output transcripts BAM."
    outputBinding:
      glob: $(inputs.transcripts_output)
  - id: other_outputs
    type:
      type: array
      items: File
    doc: "Other result files with the same prefix (hq and lq BAM and FASTA, cluster report, singletons)."
    outputBinding:
      glob: $(inputs.transcripts_output.replace(/\.bam$/, '')).*
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
