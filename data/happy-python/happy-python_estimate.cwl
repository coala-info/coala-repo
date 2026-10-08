cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - happy
  - estimate
label: happy-python_estimate
doc: "Compute haploidy from a coverage histogram.\n\nTool homepage: https://github.com/AntoineHo/HapPy"
inputs:
  - id: max_contaminant
    type:
      - 'null'
      - int
    doc: "Maximum coverage of contaminants."
    inputBinding:
      position: 1
      prefix: --max-contaminant
  - id: max_diploid
    type:
      - 'null'
      - int
    doc: "Maximum coverage of the diploid peak."
    inputBinding:
      position: 1
      prefix: --max-diploid
  - id: size
    type: int
    doc: "Estimated haploid genome size."
    inputBinding:
      position: 1
      prefix: --size
  - id: outstats
    type: string
    doc: "Path where haploidy value is written."
    inputBinding:
      position: 1
      prefix: --outstats
  - id: plot
    type:
      - 'null'
      - boolean
    doc: "Generate histogram plot."
    inputBinding:
      position: 1
      prefix: --plot
  - id: coverage_hist
    type: File
    doc: "Coverage histogram."
    inputBinding:
      position: 2
outputs:
  - id: stats
    type: File
    doc: "Haploidy value"
    outputBinding:
      glob: $(inputs.outstats)
  - id: plots
    type:
      - 'null'
      - type: array
        items: File
    doc: "Histogram plots, written with --plot"
    outputBinding:
      glob: '*.png'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/happy-python:0.2.1rc0--pyhdfd78af_0
