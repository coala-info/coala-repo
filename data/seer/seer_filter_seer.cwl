cwlVersion: v1.2
class: CommandLineTool
baseCommand: filter_seer
label: seer_filter_seer
doc: "filter_seer: post filtering of significant kmers\n\nTool homepage: https://github.com/johnlees/seer"
inputs:
  - id: kmers
    type: File
    doc: "File of output from seer"
    inputBinding:
      position: 1
      prefix: --kmers
  - id: chisq
    type: ['null', float]
    doc: "Minimum unadjusted p-value to output"
    inputBinding:
      position: 1
      prefix: --chisq
  - id: pval
    type: ['null', float]
    doc: "Minimum adjusted p-value to output"
    inputBinding:
      position: 1
      prefix: --pval
  - id: maf
    type: ['null', float]
    doc: "Minimum maf/max 1-maf to output"
    inputBinding:
      position: 1
      prefix: --maf
  - id: beta
    type: ['null', float]
    doc: "Minimum |beta| to output"
    inputBinding:
      position: 1
      prefix: --beta
  - id: substr
    type: ['null', boolean]
    doc: "Remove smaller kmers completely represented elsewhere"
    inputBinding:
      position: 1
      prefix: --substr
  - id: pos_beta
    type: ['null', boolean]
    doc: "Output positive effect sizes only"
    inputBinding:
      position: 1
      prefix: --pos_beta
  - id: sort
    type: ['null', string]
    doc: "Field to sort on: chisq, pval, maf or beta"
    inputBinding:
      position: 1
      prefix: --sort
outputs:
  - id: output
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/seer:v1.1.4-2b2-deb_cv1
stdout: seer_filter_seer.out
