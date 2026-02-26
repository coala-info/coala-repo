cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfold_diff
label: gfold_diff
doc: "Generalized fold change for ranking differentially expressed genes from RNA-seq
  data.\n\nTool homepage: https://github.com/nickgerace/gfold"
inputs:
  - id: sample1
    type: string
    doc: Sample 1 identifier
    inputBinding:
      position: 101
      prefix: -s1
  - id: sample2
    type: string
    doc: Sample 2 identifier
    inputBinding:
      position: 101
      prefix: -s2
  - id: suffix
    type: string
    doc: Suffix for sample files
    inputBinding:
      position: 101
      prefix: -suf
outputs:
  - id: output_file
    type: File
    doc: Output file name for differential expression results
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfold:1.1.4--gsl1.16_1
