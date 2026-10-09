cwlVersion: v1.2
class: CommandLineTool
baseCommand: humann2_rna_dna_norm
label: humann2_humann2_rna_dna_norm
doc: "HUMAnN2 utility for normalizing combined meta'omic sequencing data. Given a DNA table and a RNA table, produce smoothed RNA and DNA values as well as relative expression values.\n\nTool homepage: http://huttenhower.sph.harvard.edu/humann2"
inputs:
  - id: input_dna
    type: File
    doc: "Original DNA output table (tsv or biom format)"
    inputBinding:
      position: 101
      prefix: "--input_dna"
  - id: input_rna
    type: File
    doc: "Original RNA output table (tsv or biom format)"
    inputBinding:
      position: 102
      prefix: "--input_rna"
  - id: output_basename
    type:
      - 'null'
      - string
    doc: "Path/basename for the three output tables; DEFAULT=results"
    inputBinding:
      position: 103
      prefix: "--output_basename"
  - id: method
    type:
      - 'null'
      - string
    doc: "Choice of smoothing method: laplace or witten_bell; DEFAULT=laplace"
    inputBinding:
      position: 104
      prefix: "--method"
  - id: log_transform
    type:
      - 'null'
      - boolean
    doc: "Report log-transformed relative expression values"
    inputBinding:
      position: 105
      prefix: "--log_transform"
  - id: log_base
    type:
      - 'null'
      - float
    doc: "Base for log transformation (if requested); DEFAULT=2."
    inputBinding:
      position: 106
      prefix: "--log_base"
outputs:
  - id: outputs
    type:
      type: array
      items: File
    doc: "the three output tables (smoothed DNA, smoothed RNA, relative expression)"
    outputBinding:
      glob: "$((inputs.output_basename ? inputs.output_basename : 'results') + '-*')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/humann2:2.8.1--py27_0
