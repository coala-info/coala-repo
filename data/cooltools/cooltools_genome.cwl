cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cooltools
  - genome
label: cooltools_genome
doc: "Utilities for binned genome assemblies.\n\nTool homepage: https://github.com/mirnylab/cooltools"
inputs:
  - id: binnify
    type:
      - 'null'
      - boolean
    doc: binnify command
    inputBinding:
      position: 101
  - id: digest
    type:
      - 'null'
      - boolean
    doc: digest command
    inputBinding:
      position: 101
  - id: fetch_chromsizes
    type:
      - 'null'
      - boolean
    doc: fetch-chromsizes command
    inputBinding:
      position: 101
  - id: gc
    type:
      - 'null'
      - boolean
    doc: gc command
    inputBinding:
      position: 101
  - id: genecov
    type:
      - 'null'
      - boolean
    doc: genecov command
    inputBinding:
      position: 101
  - id: genecov_bins_path
    type:
      - 'null'
      - File
    doc: BINS_PATH is the path to bintable.
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cooltools:0.7.1--py311h93dcfea_3
stdout: cooltools_genome.out
