cwlVersion: v1.2
class: CommandLineTool
baseCommand: darkprofiler
label: darkprofiler
doc: "DarkProfiler: classify peptides into canonical, alternative, mutant, and dark
  proteome categories.\n\nTool homepage: https://pypi.org/project/darkprofiler/"
inputs:
  - id: subcommand
    type: string
    doc: 'Subcommand to execute: download or run'
    inputBinding:
      position: 1
  - id: download_reference_bundle
    type:
      - 'null'
      - string
    doc: Download a reference genome bundle (hg19/hg38/mm10/mm39).
    inputBinding:
      position: 2
  - id: run_classification_pipeline
    type:
      - 'null'
      - string
    doc: Run DarkProfiler classification pipeline.
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/darkprofiler:0.2.6--pyhdfd78af_0
stdout: darkprofiler.out
