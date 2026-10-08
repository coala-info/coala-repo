cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fanc
  - expected
label: fanc_expected
doc: "Calculate Hi-C expected values (distance decay).\n\nTool homepage: https://github.com/vaquerizaslab/fanc"
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: "Input matrix (Hi-C, fold-change map, ...)."
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: "Output expected contacts (tsv)."
    inputBinding:
      position: 2
  - id: plot
    type:
      - 'null'
      - string
    doc: "Output file for distance decay plot (pdf)."
    inputBinding:
      position: 20
      prefix: --plot
  - id: labels
    type:
      - 'null'
      - type: array
        items: string
    doc: "Labels for input objects."
    inputBinding:
      position: 20
      prefix: --labels
  - id: chromosome
    type:
      - 'null'
      - string
    doc: "Specific chromosome to calculate expected values for."
    inputBinding:
      position: 20
      prefix: --chromosome
  - id: work_in_tmp
    type:
      - 'null'
      - boolean
    doc: "Work in temporary directory"
    inputBinding:
      position: 20
      prefix: --work-in-tmp
  - id: recalculate
    type:
      - 'null'
      - boolean
    doc: "Recalculate expected values regardless of whether they are already stored in the matrix object."
    inputBinding:
      position: 20
      prefix: --recalculate
  - id: no_norm
    type:
      - 'null'
      - boolean
    doc: "Calculate expected values on unnormalised data."
    inputBinding:
      position: 20
      prefix: --no-norm
outputs:
  - id: expected
    type: File
    doc: "Expected contacts per distance (tsv)."
    outputBinding:
      glob: $(inputs.output)
  - id: plot_file
    type:
      - 'null'
      - File
    doc: "Distance decay plot (PDF)."
    outputBinding:
      glob: $(inputs.plot)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |-
      ${ return inputs.input.map(function(f) { return {"entry": f, "writable": true}; }); }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
