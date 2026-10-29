cwlVersion: v1.2
class: CommandLineTool
baseCommand: [isoseq, tag]
label: nf-isoseq_isoseq_tag
doc: "Remove cell barcodes and UMIs from FL reads and generate tagged FL transcripts (FL to FLT)

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
  - id: flt_output
    type: string
    doc: "Output FLT BAM or ConsensusReadSet XML"
    inputBinding:
      position: 2
  - id: design
    type: ['null', string]
    doc: "Barcoding design. Specifies which bases to use as cell/molecular barcodes. [T-8U-10B]"
    inputBinding:
      position: 100
      prefix: --design
  - id: min_read_length
    type: ['null', int]
    doc: "Minimum read length after trimming. [50]"
    inputBinding:
      position: 100
      prefix: --min-read-length
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
  - id: flt_bam
    type: File
    doc: "Tagged FL transcripts (FLT) BAM"
    secondaryFiles:
      - pattern: .pbi
        required: false
    outputBinding:
      glob: $(inputs.flt_output)
  - id: log_output
    type: ['null', File]
    doc: "Log file (when log_file is set)"
    outputBinding:
      glob: $(inputs.log_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isoseq:4.3.0--h9ee0642_0
