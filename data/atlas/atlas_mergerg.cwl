cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - atlas
  - mergeRG
label: atlas_mergerg
doc: "Merging read groups in a BAM file.\n\nTool homepage: https://bitbucket.org/wegmannlab/atlas"
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
  - id: read_groups
    type: File
    doc: "Merge file with header \"receiver donor\"; donors (comma-separated) are merged into the receiver."
    inputBinding:
      position: 1
      prefix: --readGroups
  - id: keep_reads_without_rg
    type:
      - 'null'
      - boolean
    doc: "Keep reads without a read group (by default ATLAS filters them out)."
    inputBinding:
      position: 1
      prefix: --keepReadsWithoutRG
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
  - id: out_prefix
    type: string
    doc: "Prefix for all output files (ATLAS --out)."
    default: "atlas_mergeRG"
    inputBinding:
      position: 1
      prefix: --out
outputs:
  - id: log
    type: stdout
    doc: ATLAS progress report (standard output).
  - id: merged_rg_bam
    type: File
    doc: "BAM file with merged read groups, with index."
    secondaryFiles:
      - pattern: .bai
        required: false
    outputBinding:
      glob: $(inputs.out_prefix)_mergedRG.bam
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
stdout: atlas_mergerg.log
