cwlVersion: v1.2
class: CommandLineTool
baseCommand: tombo
label: ont-tombo_tombo
doc: "Tombo is a suite of tools primarily for the identification of modified nucleotides
  from nanopore sequencing data.\nTombo also provides tools for the analysis and visualization
  of raw nanopore signal.\n\nTool homepage: https://github.com/nanoporetech/tombo"
inputs:
  - id: build_model
    type:
      - 'null'
      - boolean
    doc: Create canonical and alternative base Tombo models.
    inputBinding:
      position: 101
  - id: detect_modifications
    type:
      - 'null'
      - boolean
    doc: Perform statistical testing to detect non-standard nucleotides.
    inputBinding:
      position: 101
  - id: filter
    type:
      - 'null'
      - boolean
    doc: Apply filter to Tombo index file for specified criterion.
    inputBinding:
      position: 101
  - id: plot
    type:
      - 'null'
      - boolean
    doc: Save plots to visualize raw nanopore signal or testing results.
    inputBinding:
      position: 101
  - id: preprocess
    type:
      - 'null'
      - boolean
    doc: Pre-process nanopore reads for Tombo processing.
    inputBinding:
      position: 101
  - id: resquiggle
    type:
      - 'null'
      - boolean
    doc: Re-annotate raw signal with genomic alignment from existing basecalls.
    inputBinding:
      position: 101
  - id: text_output
    type:
      - 'null'
      - boolean
    doc: Output Tombo results in text files.
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
stdout: ont-tombo_tombo.out
