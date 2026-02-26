cwlVersion: v1.2
class: CommandLineTool
baseCommand: wiggletools_ttest
label: wiggletools_ttest
doc: "Performs a t-test on wiggle files.\n\nTool homepage: https://github.com/Ensembl/WiggleTools"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Two wiggle files to compare.
    inputBinding:
      position: 1
  - id: all
    type:
      - 'null'
      - boolean
    doc: Output all statistics.
    inputBinding:
      position: 102
      prefix: --all
  - id: degrees_freedom
    type:
      - 'null'
      - boolean
    doc: Output the degrees of freedom.
    inputBinding:
      position: 102
      prefix: --degrees-freedom
  - id: mean
    type:
      - 'null'
      - boolean
    doc: Output the mean of each wiggle file.
    inputBinding:
      position: 102
      prefix: --mean
  - id: pvalue
    type:
      - 'null'
      - boolean
    doc: Output the p-value.
    inputBinding:
      position: 102
      prefix: --pvalue
  - id: stddev
    type:
      - 'null'
      - boolean
    doc: Output the standard deviation of each wiggle file.
    inputBinding:
      position: 102
      prefix: --stddev
  - id: tstat
    type:
      - 'null'
      - boolean
    doc: Output the t-statistic.
    inputBinding:
      position: 102
      prefix: --tstat
  - id: variance
    type:
      - 'null'
      - boolean
    doc: Output the variance of each wiggle file.
    inputBinding:
      position: 102
      prefix: --variance
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file to write results to.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wiggletools:1.2.11--h7118728_10
