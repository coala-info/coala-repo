cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl HLAProfiler.pl
label: hlaprofiler_HLAProfiler.pl
doc: "A tool for predicting HLA types using NGS Paired-end sequencing data.\n\nTool
  homepage: https://github.com/ExpressionAnalysis/HLAProfiler"
inputs:
  - id: module
    type: string
    doc: 'The module to run. Available modules: build, predict, test_modules, test,
      create_taxonomy, build_taxonomy, create_profiles, filter, count_reads, predict_only.'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hlaprofiler:1.0.5--0
stdout: hlaprofiler_HLAProfiler.pl.out
