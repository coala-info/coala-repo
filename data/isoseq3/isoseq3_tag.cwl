cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - isoseq
  - tag
label: isoseq3_tag
doc: "Remove cell barcodes and UMIs from FL reads and generate tagged FL transcripts (FL to FLT)\n\nTool homepage: https://github.com/PacificBiosciences/IsoSeq3"
inputs:
  - id: demux_bam
    type: File
    doc: "Input cDNA demuxed BAM."
    inputBinding:
      position: 1
  - id: flt_output
    type: string
    default: flt.bam
    doc: "Output FLT BAM."
    inputBinding:
      position: 2
  - id: design
    type: ['null', string]
    doc: "Barcoding design. Specifies which bases to use as cell/molecular barcodes."
    inputBinding:
      position: 103
      prefix: --design
  - id: min_read_length
    type: ['null', int]
    doc: "Minimum read length after trimming."
    inputBinding:
      position: 103
      prefix: --min-read-length
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
  - id: flt_bam
    type: File
    doc: "Output tagged FLT BAM."
    outputBinding:
      glob: $(inputs.flt_output)
  - id: other_outputs
    type:
      type: array
      items: File
    doc: "Other result files with the same prefix (BAM index, reports)."
    outputBinding:
      glob: $(inputs.flt_output.replace(/\.bam$/, '')).*
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
