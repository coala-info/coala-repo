cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - happy
  - autoest
label: happy-python_autoest
doc: "Detect peaks and compute haploidy metrics from the coverage histogram.\n\nTool homepage: https://github.com/AntoineHo/HapPy"
inputs:
  - id: min_peak
    type:
      - 'null'
      - int
    doc: "Minimum peak height [default: 15000]."
    inputBinding:
      position: 1
      prefix: --min-peak
  - id: prominence
    type:
      - 'null'
      - int
    doc: "Minimum peak prominence (see SciPy docs) [default: 10000]."
    inputBinding:
      position: 1
      prefix: --prominence
  - id: window
    type:
      - 'null'
      - float
    doc: "Window size for peak matching modifier [default: 1.5]."
    inputBinding:
      position: 1
      prefix: --window
  - id: score
    type:
      - 'null'
      - float
    doc: "Score threshold for outputting to file [default: 0.75]."
    inputBinding:
      position: 1
      prefix: --score
  - id: plot
    type:
      - 'null'
      - boolean
    doc: "Generate plots."
    inputBinding:
      position: 1
      prefix: --plot
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Generate debug histogram plot."
    inputBinding:
      position: 1
      prefix: --debug
  - id: size
    type: string
    doc: "Estimated haploid genome size (Recognized modifiers: K,M,G)."
    inputBinding:
      position: 1
      prefix: --size
  - id: outstats
    type: string
    doc: "Path to file where the metrics values will be written."
    inputBinding:
      position: 1
      prefix: --outstats
  - id: coverage_hist
    type: File
    doc: "Coverage histogram."
    inputBinding:
      position: 2
outputs:
  - id: stats
    type: File
    doc: "Haploidy metrics"
    outputBinding:
      glob: $(inputs.outstats)
  - id: plots
    type:
      - 'null'
      - type: array
        items: File
    doc: "Plots, written with --plot or --debug"
    outputBinding:
      glob: '*.png'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/happy-python:0.2.1rc0--pyhdfd78af_0
