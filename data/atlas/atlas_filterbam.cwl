cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - atlas
  - filterBAM
label: atlas_filterbam
doc: "Writing reads that pass filters to a new BAM file.\n\nTool homepage: https://bitbucket.org/wegmannlab/atlas"
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
  - id: out_qual
    type:
      - 'null'
      - string
    doc: "Constrain written quality scores to this range, e.g. \"0,41\"."
    inputBinding:
      position: 1
      prefix: --outQual
  - id: write_binned_qualities
    type:
      - 'null'
      - boolean
    doc: "Write Illumina-binned quality scores."
    inputBinding:
      position: 1
      prefix: --writeBinnedQualities
  - id: accepted_distance
    type:
      - 'null'
      - int
    doc: "Distance up to which mates are not considered orphans."
    inputBinding:
      position: 1
      prefix: --acceptedDistance
  - id: keep_orphans
    type:
      - 'null'
      - boolean
    doc: "Keep orphaned reads."
    inputBinding:
      position: 1
      prefix: --keepOrphans
  - id: remove_soft_clipped_bases
    type:
      - 'null'
      - boolean
    doc: "Remove all soft-clipped bases from reads."
    inputBinding:
      position: 1
      prefix: --removeSoftClippedBases
  - id: filter_mq
    type:
      - 'null'
      - string
    doc: "Keep reads with mapping quality in this range, e.g. \"[30,256]\"."
    inputBinding:
      position: 1
      prefix: --filterMQ
  - id: filter_read_length
    type:
      - 'null'
      - string
    doc: "Keep reads with length in this range, e.g. \"[30,150]\"."
    inputBinding:
      position: 1
      prefix: --filterReadLength
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
    default: "atlas_filterBAM"
    inputBinding:
      position: 1
      prefix: --out
outputs:
  - id: log
    type: stdout
    doc: ATLAS progress report (standard output).
  - id: filtered_bam
    type: File
    doc: "Filtered BAM file with index."
    secondaryFiles:
      - pattern: .bai
        required: false
    outputBinding:
      glob: $(inputs.out_prefix)_filtered.bam
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
stdout: atlas_filterbam.log
