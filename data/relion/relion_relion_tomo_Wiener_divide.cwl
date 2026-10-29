cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_tomo_Wiener_divide
label: relion_relion_tomo_Wiener_divide
doc: "Divide a data term by a weight term with a Wiener filter and taper the result (subtomogram reconstruction\
  \ step).\n\nTool homepage: https://github.com/3dem/relion"
inputs:
  - id: data_term
    type: File
    doc: Data term
    inputBinding:
      position: 101
      prefix: --i
  - id: weight_term
    type: File
    doc: Weight term (the help text names it Data term)
    inputBinding:
      position: 101
      prefix: --w
  - id: output
    type: string
    doc: Output filename
    inputBinding:
      position: 101
      prefix: --o
  - id: SNR
    type:
      - 'null'
      - float
    doc: 'Assumed SNR (RELION default: 0.0001)'
    inputBinding:
      position: 101
      prefix: --SNR
  - id: tw
    type:
      - 'null'
      - float
    doc: 'Taper edge width (RELION default: 10)'
    inputBinding:
      position: 101
      prefix: --tw
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads (RELION default: 5)'
    inputBinding:
      position: 101
      prefix: --j
outputs:
  - id: output_map
    type: File
    doc: Wiener-divided map
    outputBinding:
      glob: $(inputs.output)
  - id: debug_files
    type:
      type: array
      items: File
    doc: Debug files the program writes
    outputBinding:
      glob: debug_*
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_tomo_Wiener_divide.out
