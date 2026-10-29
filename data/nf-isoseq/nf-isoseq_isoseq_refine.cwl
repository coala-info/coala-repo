cwlVersion: v1.2
class: CommandLineTool
baseCommand: [isoseq, refine]
label: nf-isoseq_isoseq_refine
doc: "Remove polyA and concatemers from FL reads and generate FLNC transcripts (FL to FLNC)

Tool homepage: https://github.com/PacificBiosciences/pbbioconda"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: demux_bam
    type: File
    doc: "Input cDNA demuxed BAM or ConsensusReadSet XML"
    secondaryFiles:
      - pattern: .pbi
        required: false
    inputBinding:
      position: 1
  - id: primer_fasta
    type: File
    doc: "Input primer FASTA or BarcodeSet XML"
    inputBinding:
      position: 2
  - id: flnc_output
    type: string
    doc: "Output flnc BAM or ConsensusReadSet XML"
    inputBinding:
      position: 3
  - id: min_polya_length
    type: ['null', int]
    doc: "Minimum poly(A) tail length. [20]"
    inputBinding:
      position: 100
      prefix: --min-polya-length
  - id: require_polya
    type: ['null', boolean]
    doc: "Require FL reads to have a poly(A) tail and remove it."
    inputBinding:
      position: 100
      prefix: --require-polya
  - id: min_rq
    type: ['null', float]
    doc: "Minimum CCS RQ. Default is -1, deactivated [-1]"
    inputBinding:
      position: 100
      prefix: --min-rq
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
  - id: verbose
    type: ['null', boolean]
    doc: "Use verbose output."
    inputBinding:
      position: 100
      prefix: --verbose
outputs:
  - id: flnc_bam
    type: File
    doc: "FLNC transcripts BAM"
    secondaryFiles:
      - pattern: .pbi
        required: false
    outputBinding:
      glob: $(inputs.flnc_output)
  - id: consensusreadset_xml
    type: ['null', File]
    doc: "ConsensusReadSet XML"
    outputBinding:
      glob: $(inputs.flnc_output.replace(/\.(bam|xml)$/, '')).consensusreadset.xml
  - id: filter_summary_json
    type: ['null', File]
    doc: "Filter summary report"
    outputBinding:
      glob: $(inputs.flnc_output.replace(/\.(bam|xml)$/, '')).filter_summary.report.json
  - id: report_csv
    type: ['null', File]
    doc: "Per-read report"
    outputBinding:
      glob: $(inputs.flnc_output.replace(/\.(bam|xml)$/, '')).report.csv
  - id: log_output
    type: ['null', File]
    doc: "Log file (when log_file is set)"
    outputBinding:
      glob: $(inputs.log_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isoseq:4.3.0--h9ee0642_0
