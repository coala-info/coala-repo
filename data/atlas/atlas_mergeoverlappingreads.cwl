cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - atlas
  - mergeOverlappingReads
label: atlas_mergeoverlappingreads
doc: "Soft-clipping the overlap of paired-end reads so no base is counted twice.\n\nTool homepage: https://bitbucket.org/wegmannlab/atlas"
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
  - id: merging_method
    type:
      - 'null'
      - string
    doc: "Merging method: middle, keepFirst, keepSecond, keepFwd, keepRev or random."
    inputBinding:
      position: 1
      prefix: --mergingMethod
  - id: filter_fragment_mismatches
    type:
      - 'null'
      - string
    doc: "Remove fragments whose mismatch ratio is outside this range, e.g. \"[0,0.1]\"."
    inputBinding:
      position: 1
      prefix: --filterFragmentMismatches
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
    default: "atlas_mergeOverlappingReads"
    inputBinding:
      position: 1
      prefix: --out
outputs:
  - id: log
    type: stdout
    doc: ATLAS progress report (standard output).
  - id: merged_bam
    type: File
    doc: "BAM file with merged reads, with index."
    secondaryFiles:
      - pattern: .bai
        required: false
    outputBinding:
      glob: $(inputs.out_prefix)_merged.bam
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
stdout: atlas_mergeoverlappingreads.log
