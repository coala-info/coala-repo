cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fanc
  - cis-trans
label: fanc_cis_trans
doc: "Calculate the cis/trans ratio of Hi-C objects.\n\nTool homepage: https://github.com/vaquerizaslab/fanc"
inputs:
  - id: hic
    type:
      type: array
      items: File
    doc: "Hic object(s) for cis/trans calculation."
    inputBinding:
      position: 1
  - id: output
    type:
      - 'null'
      - string
    doc: "Output file."
    inputBinding:
      position: 20
      prefix: --output
  - id: norm
    type:
      - 'null'
      - boolean
    doc: "Normalise ratio to the prior ratio of possible cis / trans contacts."
    inputBinding:
      position: 20
      prefix: --norm
outputs:
  - id: ratio_stdout
    type: stdout
    doc: "Cis/trans ratios printed to standard output when no output file is given."
  - id: ratio_file
    type:
      - 'null'
      - File
    doc: "Cis/trans ratio table."
    outputBinding:
      glob: $(inputs.output)
stdout: cis_trans_stdout.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
