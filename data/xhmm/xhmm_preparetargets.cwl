cwlVersion: v1.2
class: CommandLineTool
baseCommand: [xhmm]
label: xhmm_preparetargets
doc: "Sort all target intervals, merge overlapping ones, and print the resulting interval list\n\nTool homepage: http://atgu.mgh.harvard.edu/xhmm/index.shtml"
inputs:
  - id: targets
    type: {type: array, items: File, inputBinding: {prefix: --targets}}
    doc: "Input targets lists"
    inputBinding:
      position: 10
  - id: reference_fasta
    type: ['null', File]
    secondaryFiles:
      - pattern: .fai
    doc: "Reference FASTA file (MUST have .fai index file)"
    inputBinding:
      position: 10
      prefix: --referenceFASTA
  - id: merged_targets
    type: string
    default: merged_targets.interval_list
    doc: "Output targets list"
    inputBinding:
      position: 10
      prefix: --mergedTargets
outputs:
  - id: merged_targets_file
    type: ['null', File]
    doc: "Merged targets list"
    outputBinding:
      glob: $(inputs.merged_targets)
  - id: stdout
    type: stdout
    doc: Standard output
arguments:
  - position: 1
    valueFrom: --prepareTargets
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xhmm:0.0.0.2016_01_04.cc14e52--hedee03e_3
stdout: xhmm_preparetargets.out
