cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - atlas
  - PSMC
label: atlas_psmc
doc: "Generating a PSMC input file probabilistically from a BAM file.\n\nTool homepage: https://bitbucket.org/wegmannlab/atlas"
inputs:
  - id: bam
    type: File
    doc: "Input BAM file."
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      position: 1
      prefix: --bam
  - id: keep_reads_without_rg
    type:
      - 'null'
      - boolean
    doc: "Keep reads without a read group (by default ATLAS filters them out)."
    inputBinding:
      position: 1
      prefix: --keepReadsWithoutRG
  - id: fasta
    type:
      - 'null'
      - File
    doc: "Reference genome FASTA (with .fai index)."
    secondaryFiles:
      - pattern: .fai
        required: false
    inputBinding:
      position: 1
      prefix: --fasta
  - id: theta
    type:
      - 'null'
      - float
    doc: "Prior for heterozygosity."
    inputBinding:
      position: 1
      prefix: --theta
  - id: confidence
    type:
      - 'null'
      - float
    doc: "Confidence threshold to call a window T or K."
    inputBinding:
      position: 1
      prefix: --confidence
  - id: window
    type:
      - 'null'
      - int
    doc: "Window size in bp (at least the maximum read length)."
    inputBinding:
      position: 1
      prefix: --window
  - id: min_maf
    type:
      - 'null'
      - float
    doc: "Keep only sites with at least this minor allele frequency."
    inputBinding:
      position: 1
      prefix: --minMAF
  - id: filter_mq
    type:
      - 'null'
      - string
    doc: "Keep reads with mapping quality in this range, e.g. \"[30,256]\"."
    inputBinding:
      position: 1
      prefix: --filterMQ
  - id: chr
    type:
      - 'null'
      - string
    doc: "Comma-separated list of chromosomes to use."
    inputBinding:
      position: 1
      prefix: --chr
  - id: out_prefix
    type: string
    doc: "Prefix for all output files (ATLAS --out)."
    default: "atlas_PSMC"
    inputBinding:
      position: 1
      prefix: --out
outputs:
  - id: log
    type: stdout
    doc: ATLAS progress report (standard output).
  - id: psmcfa
    type: File
    doc: "PSMC input file."
    outputBinding:
      glob: $(inputs.out_prefix).psmcfa
  - id: parameters
    type:
      - 'null'
      - File
    doc: "Parameters used for the run."
    outputBinding:
      glob: $(inputs.out_prefix).parameters
  - id: filter_summary
    type:
      - 'null'
      - File
    doc: "Counts of reads removed by each filter."
    outputBinding:
      glob: $(inputs.out_prefix)_filterSummary.txt
  - id: rg_info
    type:
      - 'null'
      - File
    doc: "Read group information."
    outputBinding:
      glob: $(inputs.out_prefix)_RGInfo.json
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atlas:2.0.1--hadca570_0
stdout: atlas_psmc.log
