cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - isoseq
  - refine
label: isoseq3_refine
doc: "Remove polyA and concatemers from FL reads and generate FLNC transcripts (FL to FLNC)\n\nTool homepage: https://github.com/PacificBiosciences/IsoSeq3"
inputs:
  - id: demux_input
    type: File
    doc: "Input cDNA demuxed BAM."
    inputBinding:
      position: 1
  - id: primer_input
    type: File
    doc: "Input primer FASTA."
    inputBinding:
      position: 2
  - id: flnc_output
    type: string
    default: flnc.bam
    doc: "Output flnc BAM."
    inputBinding:
      position: 3
  - id: min_polya_length
    type: ['null', int]
    doc: "Minimum poly(A) tail length."
    inputBinding:
      position: 104
      prefix: --min-polya-length
  - id: require_polya
    type: ['null', boolean]
    doc: "Require FL reads to have a poly(A) tail and remove it."
    inputBinding:
      position: 104
      prefix: --require-polya
  - id: min_rq
    type: ['null', float]
    doc: "Minimum CCS RQ. Default is -1, deactivated."
    inputBinding:
      position: 104
      prefix: --min-rq
  - id: num_threads
    type: ['null', int]
    doc: "Number of threads to use, 0 means autodetection."
    inputBinding:
      position: 104
      prefix: --num-threads
  - id: log_level
    type: ['null', string]
    doc: "Set log level. Valid choices: (TRACE, DEBUG, INFO, WARN, FATAL)."
    inputBinding:
      position: 104
      prefix: --log-level
  - id: log_file_path
    type: ['null', string]
    doc: "Log to a file, instead of stderr."
    inputBinding:
      position: 104
      prefix: --log-file
  - id: verbose
    type: ['null', boolean]
    doc: "Use verbose output."
    inputBinding:
      position: 104
      prefix: --verbose
outputs:
  - id: flnc_bam
    type: File
    doc: "Output FLNC BAM."
    outputBinding:
      glob: $(inputs.flnc_output)
  - id: flnc_bam_index
    type: ['null', File]
    doc: "PacBio BAM index of the output BAM."
    outputBinding:
      glob: $(inputs.flnc_output).pbi
  - id: report_csv
    type: ['null', File]
    doc: "Per-read report."
    outputBinding:
      glob: $(inputs.flnc_output.replace(/\.bam$/, '')).report.csv
  - id: filter_summary_json
    type: ['null', File]
    doc: "Filter summary report."
    outputBinding:
      glob: $(inputs.flnc_output.replace(/\.bam$/, '')).filter_summary.report.json
  - id: consensusreadset_xml
    type: ['null', File]
    doc: "ConsensusReadSet XML of the output."
    outputBinding:
      glob: $(inputs.flnc_output.replace(/\.bam$/, '')).consensusreadset.xml
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
