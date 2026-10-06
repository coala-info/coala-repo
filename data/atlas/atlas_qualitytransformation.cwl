cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - atlas
  - qualityTransformation
label: atlas_qualitytransformation
doc: "Printing how base quality scores are transformed by recalibration.\n\nTool homepage: https://bitbucket.org/wegmannlab/atlas"
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
  - id: rg_info_file
    type:
      - 'null'
      - File
    doc: "Read group info JSON with the recalibration model of each read group (as written by ATLAS)."
    inputBinding:
      position: 1
      prefix: --RGInfo
  - id: recal
    type:
      - 'null'
      - string
    doc: "Recalibration model for all read groups, e.g. \"quality:polynomial[0.9]\" (overrides --RGInfo)."
    inputBinding:
      position: 1
      prefix: --recal
  - id: out_prefix
    type: string
    doc: "Prefix for all output files (ATLAS --out)."
    default: "atlas_qualityTransformation"
    inputBinding:
      position: 1
      prefix: --out
outputs:
  - id: log
    type: stdout
    doc: ATLAS progress report (standard output).
  - id: quality_transformation
    type: File
    doc: "Quality transformation of the total data."
    outputBinding:
      glob: $(inputs.out_prefix)_qualityTransformation.txt
  - id: quality_transformation_per_rg
    type: File[]
    doc: "Quality transformation per read group (and total)."
    outputBinding:
      glob: $(inputs.out_prefix)*_qualityTransformation.txt
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
stdout: atlas_qualitytransformation.log
